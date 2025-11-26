import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_scaffold_meessanger.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/loading_animation.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/case_details_page/review/pages/audio_document/repository/bloc/get_file_id_bloc.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/case_details_page/review/pages/audio_document/repository/bloc/get_file_id_event.dart';
import 'package:just_audio/just_audio.dart';

class AudioItem extends StatefulWidget {
  final String fileName;
  final Duration duration;
  final String filePath;
  final String fileSize;
  final String caseID;
  final String saltKey;
  final VoidCallback onDelete;

  const AudioItem({
    super.key,
    required this.fileName,
    required this.duration,
    required this.filePath,
    required this.fileSize,
    required this.caseID,
    required this.saltKey,
    required this.onDelete,
  });

  @override
  State<AudioItem> createState() => _AudioItemState();
}

class _AudioItemState extends State<AudioItem> {
  final AudioPlayer _player = AudioPlayer();
  bool _isPlaying = false;
  bool _isUploading = false;
  Duration _position = Duration.zero;

  late final StreamSubscription<Duration> _positionSub;
  late final StreamSubscription<PlayerState> _stateSub;
  late final StreamSubscription<ProcessingState> _processingSub;

  @override
  void initState() {
    super.initState();

    _player.setFilePath(widget.filePath);

    _positionSub = _player.positionStream.listen((pos) {
      if (mounted) setState(() => _position = pos);
    });

    _stateSub = _player.playerStateStream.listen((state) {
      if (mounted) setState(() => _isPlaying = state.playing);
    });

    _processingSub = _player.processingStateStream.listen((state) async {
      if (state == ProcessingState.completed) {
        await _player.seek(Duration.zero);
        await _player.pause();
        if (mounted) {
          setState(() {
            _isPlaying = false;
            _position = Duration.zero;
          });
        }
      }
    });
  }

  Future<void> _togglePlayStop() async {
    if (_isPlaying) {
      await _player.stop();
      await _player.seek(Duration.zero);
      setState(() {
        _isPlaying = false;
        _position = Duration.zero;
      });
    } else {
      await _player.play();
    }
  }

  Future<void> _submitRecording() async {
    if (_isUploading) return; // prevent double-tap uploads
    setState(() => _isUploading = true);

    try {
    

      context.read<GetFileIdBloc>().add(
        GetFileIdEvent(
          filePath: widget.filePath,
          caseID: widget.caseID,
          docTypeID: 6,
          filename: widget.fileName,
          fileSize: widget.fileSize,
          saltKey: widget.saltKey,
          context: context,
        ),
      );
    } catch (e) {
      if (mounted) {
        CustomScaffoldMessenger.showErrorMessage(
          context,
          "Error uploading ${widget.fileName}: $e",
        );
      }
      setState(() => _isUploading = false);
    }
  }

  String _formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    return "${twoDigits(d.inMinutes.remainder(60))}:${twoDigits(d.inSeconds.remainder(60))}";
  }

  @override
  void dispose() {
    _positionSub.cancel();
    _stateSub.cancel();
    _processingSub.cancel();
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GetFileIdBloc, GetFileIdState>(
      listener: (context, state) {
        if (state is SuccessAPI && state.filePath == widget.filePath) {
          setState(() => _isUploading = false);
          widget.onDelete();
        } else if (state is GetFileIdFailure &&
            state.filePath == widget.filePath) {
          setState(() => _isUploading = false);
          CustomScaffoldMessenger.showErrorMessage(context, state.message);
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.hint1color),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  iconSize: 36,
                  icon: Icon(
                    _isPlaying ? Icons.stop_circle : Icons.play_circle_fill,
                    color: AppColors.primarycolor,
                  ),
                  onPressed: _togglePlayStop,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.fileName,
                        style: AppFonts.subheading16,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Slider(
                        padding: EdgeInsets.zero,
                        value: _position.inSeconds.toDouble().clamp(
                          0,
                          widget.duration.inSeconds.toDouble(),
                        ),
                        max: widget.duration.inSeconds.toDouble(),
                        onChanged: (value) async {
                          await _player.seek(Duration(seconds: value.toInt()));
                        },
                        activeColor: AppColors.primarycolor,
                        inactiveColor: AppColors.hint2color,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _formatDuration(_position),
                            style: AppFonts.hinttext2,
                          ),
                          Text(
                            _formatDuration(widget.duration),
                            style: AppFonts.hinttext2,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: SvgPicture.asset(
                    "assets/svg/trash.svg",
                    width: 20,
                    height: 20,
                  ),
                  onPressed: widget.onDelete,
                ),
                _isUploading
                    ? Padding(
                      padding: EdgeInsetsGeometry.all(10),
                      child: const LoadingAnimation(),
                    )
                    : IconButton(
                      onPressed: _submitRecording,
                      icon: const Icon(
                        Icons.upload,
                        color: AppColors.primarycolor,
                      ),
                    ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
