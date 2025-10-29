// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:dotted_border/dotted_border.dart';
// import 'package:ghorx_mobile_app_new/core/common_widgets/custom_button.dart';
// import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
// import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';

// class Recordaudio extends StatelessWidget {
//   const Recordaudio({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         SizedBox(height: 10),
//         Padding(
//           padding: EdgeInsets.all(10.0),
//           child: DottedBorder(
//             color: AppColors.hint1color,
//             strokeWidth: 1,
//             borderType: BorderType.RRect,
//             radius: Radius.circular(8.0),
//             dashPattern: [7, 8],
//             child: Container(
//               width: double.infinity,
//               padding: EdgeInsets.all(12.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   SvgPicture.asset("assets/svg/Document.svg"),
//                   SizedBox(height: 8),
//                   Column(
//                     children: [
//                       Text(
//                         'Drag and drop your files',
//                         style: AppFonts.subheading,
//                       ),
//                       SizedBox(height: 5.0),
//                       //   Text(
//                       //     'JPEG, PND, PDF, and MP4 formats, up to 1GB',
//                       //     style: AppFonts.hinttext2,
//                       //   ),
//                       //  SizedBox(height: 10),
//                       SizedBox(
//                         width: 100,
//                         child: CustomButton(
//                           text: "Select",
//                           onPressed: () {},
//                           color: AppColors.white,
//                           colortext: AppColors.textPrimary,
//                           borderColor: AppColors.hint1color,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//         SizedBox(height: 15),
//         Padding(
//           padding: EdgeInsets.all(10.0),
//           child: DottedBorder(
//             color: AppColors.hint1color,
//             strokeWidth: 1,
//             borderType: BorderType.RRect,
//             radius: Radius.circular(8.0),
//             dashPattern: [7, 8],
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 SizedBox(height: 10),
//                 SvgPicture.asset("assets/svg/record.svg"),
//                 SizedBox(height: 8.0),
//                 Column(
//                   children: [
//                     Text('Record Audio Summary', style: AppFonts.subheading),
//                     SizedBox(height: 5.0),

//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         SizedBox(
//                           width: 130,
//                           child: CustomButton(
//                             text: "Start Recording",
//                             onPressed: () {},
//                             color: AppColors.warningred,
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 10.0),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//         SizedBox(height: 10),
//         Padding(
//           padding: EdgeInsets.all(10.0),
//           child: Align(
//             alignment: Alignment.topLeft,
//             child: Text("Uploaded Files", style: AppFonts.subheading16),
//           ),
//         ),
//         Padding(
//           padding: EdgeInsets.all(8.0),
//           child: Container(
//             width: double.infinity,
//             padding: EdgeInsets.all(12.0),
//             decoration: BoxDecoration(
//               border: Border.all(color: AppColors.hint1color),
//               borderRadius: BorderRadius.circular(8.0),
//             ),
//             child: Row(
//               children: [
//                 SvgPicture.asset("assets/svg/pdfIcons.svg"),
//                 SizedBox(width: 10),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "Report name_T1.pdf",
//                         style: AppFonts.subheading16.copyWith(fontSize: 16),
//                       ),
//                       SizedBox(height: 5),
//                       Wrap(
//                         spacing: 4.0,
//                         runSpacing: 4.0,
//                         crossAxisAlignment: WrapCrossAlignment.center,
//                         children: [
//                           Text("23.5MB | 55%", style: AppFonts.hinttext2),
//                           Icon(
//                             Icons.circle,
//                             size: 6,
//                             color: AppColors.hint2color,
//                           ),
//                           Text("37 sec left", style: AppFonts.hinttext2),
//                           Row(
//                             children: [
//                               Icon(
//                                 Icons.hourglass_empty,
//                                 size: 16,
//                                 color: AppColors.hint2color,
//                               ),
//                               SizedBox(width: 2),
//                               Text("Uploading", style: AppFonts.hinttext2),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 SvgPicture.asset("assets/svg/trash.svg"),
//               ],
//             ),
//           ),
//         ),
//         SizedBox(height: 10),
//         Padding(
//           padding: EdgeInsets.all(10.0),
//           child: Container(
//             width: double.infinity,
//             padding: EdgeInsets.all(12.0),
//             decoration: BoxDecoration(
//               border: Border.all(color: AppColors.hint1color),
//               borderRadius: BorderRadius.circular(8.0),
//             ),
//             child: Row(
//               children: [
//                 SvgPicture.asset("assets/svg/pdfIcons.svg"),
//                 SizedBox(width: 10),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "Report name_Agt_1234.pdf",
//                         style: AppFonts.subheading16.copyWith(fontSize: 16),
//                       ),
//                       SizedBox(height: 5),
//                       Wrap(
//                         spacing: 4.0,
//                         crossAxisAlignment: WrapCrossAlignment.center,
//                         children: [
//                           Text("23.5MB | 100%", style: AppFonts.hinttext2),
//                           Icon(
//                             Icons.circle,
//                             size: 6,
//                             color: AppColors.hint2color,
//                           ),
//                           Text(
//                             "Upload Successfully",
//                             style: AppFonts.hinttext2,
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 SvgPicture.asset("assets/svg/trash.svg"),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_button.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:just_audio/just_audio.dart';

class Recordaudio extends StatefulWidget {
  const Recordaudio({super.key});

  @override
  State<Recordaudio> createState() => _RecordaudioState();
}

class _RecordaudioState extends State<Recordaudio> {
  final AudioRecorder _recorder = AudioRecorder();
  bool _isRecording = false;
  Timer? _timer;
  int _seconds = 0;

  /// Store list of recorded audios
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
    }
  }

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

  String get _formattedTime {
    final minutes = (_seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (_seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$secs';
  }

  void _deleteRecording(int index) {
    final filePath = _recordings[index]['path'];
    File(filePath).deleteSync();
    setState(() => _recordings.removeAt(index));
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
        // --- Record Audio Section ---
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: DottedBorder(
            color: AppColors.hint1color,
            strokeWidth: 1,
            borderType: BorderType.RRect,
            radius: const Radius.circular(8.0),
            dashPattern: const [7, 8],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                SvgPicture.asset("assets/svg/record.svg"),
                const SizedBox(height: 8.0),
                Text('Record Audio Summary', style: AppFonts.subheading),
                const SizedBox(height: 5.0),
                if (_isRecording)
                  Text(
                    "Recording... $_formattedTime",
                    style: AppFonts.subheading
                        .copyWith(color: AppColors.warningred),
                  ),
                const SizedBox(height: 10.0),
                SizedBox(
                  width: 160,
                  child: CustomButton(
                    text: _isRecording ? "Stop Recording" : "Start Recording",
                    onPressed: _isRecording ? _stopRecording : _startRecording,
                    color: _isRecording
                        ? AppColors.textPrimary
                        : AppColors.warningred,
                  ),
                ),
                const SizedBox(height: 10.0),
              ],
            ),
          ),
        ),

        // --- List of Recorded Audios ---
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
          return _AudioItem(
            name: recording['name'],
            duration: recording['duration'],
            filePath: recording['path'],
            onDelete: () => _deleteRecording(index),
          );
        }),
      ],
    );
  }
}

class _AudioItem extends StatefulWidget {
  final String name;
  final Duration duration;
  final String filePath;
  final VoidCallback onDelete;

  const _AudioItem({
    required this.name,
    required this.duration,
    required this.filePath,
    required this.onDelete,
  });

  @override
  State<_AudioItem> createState() => _AudioItemState();
}

class _AudioItemState extends State<_AudioItem> {
  final AudioPlayer _player = AudioPlayer();
  bool _isPlaying = false;
  Duration _position = Duration.zero;

  @override
  void initState() {
    super.initState();
    _player.setFilePath(widget.filePath);
    _player.positionStream.listen((pos) {
      setState(() => _position = pos);
    });
    _player.playerStateStream.listen((state) {
      setState(() => _isPlaying = state.playing);
    });
  }

  Future<void> _togglePlay() async {
    if (_player.playing) {
      await _player.pause();
    } else {
      await _player.play();
    }
  }

  String _formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    return "${twoDigits(d.inMinutes.remainder(60))}:${twoDigits(d.inSeconds.remainder(60))}";
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.hint1color),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          children: [
            IconButton(
              iconSize: 40,
              icon: Icon(
                _isPlaying ? Icons.pause_circle_filled : Icons.play_circle_fill,
                color: AppColors.textPrimary,
              ),
              onPressed: _togglePlay,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.name, style: AppFonts.subheading16),
                  const SizedBox(height: 4),
                  Slider(
                    value: _position.inSeconds.toDouble().clamp(0, widget.duration.inSeconds.toDouble()),
                    max: widget.duration.inSeconds.toDouble(),
                    onChanged: (value) async {
                      await _player.seek(Duration(seconds: value.toInt()));
                    },
                    activeColor: AppColors.textPrimary,
                    inactiveColor: AppColors.hint1color,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_formatDuration(_position), style: AppFonts.hinttext2),
                      Text(_formatDuration(widget.duration), style: AppFonts.hinttext2),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              icon: SvgPicture.asset("assets/svg/trash.svg", width: 20, height: 20),
              onPressed: widget.onDelete,
            ),
          ],
        ),
      ),
    );
  }
}

