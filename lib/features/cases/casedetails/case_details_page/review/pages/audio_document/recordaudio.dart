import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_button.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_dotted_container.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/loading_animation.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
import 'package:ghorx_mobile_app_new/core/constants/file_picker.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/case_details_page/review/pages/audio_document/repository/bloc/get_file_id_bloc.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/case_details_page/review/pages/audio_document/repository/bloc/get_file_id_event.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/case_details_page/review/pages/audio_document/widget/audio_item.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/case_details_page/review/pages/audio_document/widget/pick_file_dialogue_box.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:just_audio/just_audio.dart';

class Recordaudio extends StatefulWidget {
  final String caseID;
  const Recordaudio({super.key, required this.caseID});

  @override
  State<Recordaudio> createState() => _RecordaudioState();
}

class _RecordaudioState extends State<Recordaudio> {
  final AudioRecorder _recorder = AudioRecorder();
  bool _isRecording = false;
  Timer? _timer;
  int _seconds = 0;
  bool isSelcted = false;
  bool isLoading = false;

  final List<Map<String, dynamic>> _recordings = [];

  Future<void> _startRecording() async {
    if (await _recorder.hasPermission()) {
      final dir = await getApplicationDocumentsDirectory();
      final path =
          '${dir.path}/recording_${DateTime.now().millisecondsSinceEpoch}.m4a';

      await _recorder.start(
        const RecordConfig(encoder: AudioEncoder.aacLc, bitRate: 128000),
        path: path,
      );

      setState(() {
        _isRecording = true;
        _seconds = 0;
      });

      _timer = Timer.periodic(const Duration(seconds: 1), (_) {
        setState(() => _seconds++);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Microphone permission not granted.')),
      );
    }
  }

  // --- Recording stop ---
  Future<void> _stopRecording() async {
    final path = await _recorder.stop();
    _timer?.cancel();

    if (path != null) {
      final player = AudioPlayer();
      await player.setFilePath(path);
      final duration = player.duration ?? Duration.zero;
      player.dispose();

      setState(() {
        _recordings.add({
          'path': path,
          'name': path.split('/').last,
          'duration': duration,
        });
        _isRecording = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Recording saved: ${path.split('/').last}')),
      );
    }
  }

  // --- Delete recording ---
  void _deleteRecording(int index) {
    final filePath = _recordings[index]['path'];
    File(filePath).deleteSync();
    setState(() => _recordings.removeAt(index));
  }

  // --- Format timer ---
  String get _formattedTime {
    final minutes = (_seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (_seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$secs';
  }

  @override
  void dispose() {
    _timer?.cancel();
    _recorder.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // --- File Upload / Scan Section ---
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: CustomDottedBorderContainer(
            strokeWidth: 1,
            dashWidth: 10,
            dashSpace: 3,
            borderRadius: BorderRadius.circular(8),
            color: AppColors.hint1color,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/svg/Document.svg"),
                  const SizedBox(height: 8),
                  Text('Drag and drop your files', style: AppFonts.subheading),
                  const SizedBox(height: 5),
                  isSelcted
                      ? BlocBuilder<GetFileIdBloc, GetFileIdState>(
                        builder: (context, state) {
                          if (state is GetFileIdLoading) {
                            setState(() => isLoading = true);
                            return const Center(child: LoadingAnimation());
                          }
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // --- Upload Button ---
                              Expanded(
                                child: SizedBox(
                                  height: 70,
                                  child: CustomDottedBorderContainer(
                                    color: AppColors.textPrimary,
                                    strokeWidth: 1,
                                    dashWidth: 3,
                                    dashSpace: 3,
                                    borderRadius: BorderRadius.circular(8),
                                    padding: EdgeInsets.zero,
                                    child: PickFileDialogueBox(
                                      icon: Icons.file_upload_outlined,
                                      label: "Upload Doc",
                                      onTap: () async {
                                        final imagePickerService =
                                            ImagePickerService();
                                        await imagePickerService.pickFile(
                                          context,
                                        );

                                        if (imagePickerService
                                            .fileList
                                            .isNotEmpty) {
                                          final file =
                                              imagePickerService.fileList.first;
                                          final fileSize =
                                              (await file.length()).toString();
                                          final fileName =
                                              file.path.split('/').last;
                                          final filePath = file.path;
                                          context.read<GetFileIdBloc>().add(
                                            GetFileIdEvent(
                                              filePath: filePath,
                                              caseID: widget.caseID,
                                              docTypeID: 1,
                                              filename: fileName,
                                              fileSize: fileSize,
                                              context: context,
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              // --- Scan Button ---
                              Expanded(
                                child: SizedBox(
                                  height: 70,
                                  child: CustomDottedBorderContainer(
                                    color: AppColors.textPrimary,
                                    strokeWidth: 1,
                                    dashWidth: 3,
                                    dashSpace: 3,
                                    borderRadius: BorderRadius.circular(8),
                                    child: PickFileDialogueBox(
                                      icon: Icons.camera_alt_outlined,
                                      label: "Scan",
                                      onTap: () async {
                                        final imagePickerService =
                                            ImagePickerService();
                                        await imagePickerService
                                            .pickImageFromCamera(context);

                                        if (imagePickerService
                                            .fileList
                                            .isNotEmpty) {
                                          final file =
                                              imagePickerService
                                                      .fileList
                                                      .isNotEmpty
                                                  ? imagePickerService
                                                      .fileList
                                                      .first
                                                  : File(
                                                    imagePickerService
                                                        .imageFileList
                                                        .first
                                                        .path,
                                                  );

                                          final fileSize =
                                              (await file.length()).toString();
                                          final fileName =
                                              file.path.split('/').last;
                                          final filePath = file.path;

                                          context.read<GetFileIdBloc>().add(
                                            GetFileIdEvent(
                                              filePath: filePath,
                                              caseID: widget.caseID,
                                              docTypeID: 1,
                                              filename: fileName,
                                              fileSize: fileSize,
                                              context: context,
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      )
                      : SizedBox(
                        width: 100,
                        child: CustomButton(
                          text: "Select",
                          onPressed: () {
                            setState(() {
                              isSelcted = true;
                            });
                          },
                          color: AppColors.white,
                          colortext: AppColors.textPrimary,
                          borderColor: AppColors.hint1color,
                        ),
                      ),
                ],
              ),
            ),
          ),
        ),

        // --- Record Audio Section ---
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: CustomDottedBorderContainer(
            strokeWidth: 1,
            dashWidth: 10,
            dashSpace: 3,
            borderRadius: BorderRadius.circular(8),
            color: AppColors.hint1color,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/svg/record.svg"),
                  const SizedBox(height: 8),
                  Text('Record Audio Summary', style: AppFonts.subheading),
                  if (_isRecording)
                    Text(
                      "Recording... $_formattedTime",
                      style: AppFonts.subheading.copyWith(
                        color: AppColors.warningred,
                      ),
                    ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 160,
                    child: CustomButton(
                      text: _isRecording ? "Stop Recording" : "Start Recording",
                      onPressed:
                          _isRecording ? _stopRecording : _startRecording,
                      color:
                          _isRecording
                              ? AppColors.textPrimary
                              : AppColors.warningred,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        // --- Recorded Audio List ---
        if (_recordings.isNotEmpty)
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text("Recorded Audios", style: AppFonts.subheading16),
            ),
          ),
        ..._recordings.asMap().entries.map((entry) {
          final index = entry.key;
          final recording = entry.value;
          final file = File(recording['path']);
          final fileSizeInBytes = file.lengthSync();
          final fileSizeInKB = (fileSizeInBytes / 1024).toStringAsFixed(2);

          return AudioItem(
            isLoading: isLoading,
            fileName: recording['name'],
            duration: recording['duration'],
            filePath: recording['path'],
            fileSize: '$fileSizeInKB KB',
            caseID: widget.caseID,
            onDelete: () => _deleteRecording(index),
          );
        }),
      ],
    );
  }
}
