import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:just_audio/just_audio.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/case_details_page/repository/model/case_details_model.dart';

class Audiosummery extends StatefulWidget {
  final List<AudioSummaryModel>? audiosummery;

  const Audiosummery({super.key, required this.audiosummery});

  @override
  State<Audiosummery> createState() => _AudiosummeryState();
}

class _AudiosummeryState extends State<Audiosummery> {
  final AudioPlayer _player = AudioPlayer();
  int? _playingIndex;

  Duration _total = Duration.zero;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    _player.positionStream.listen((position) {
      if (!mounted) return;
    });

    _player.durationStream.listen((duration) {
      if (!mounted) return;
      if (duration != null) setState(() => _total = duration);
    });

    _player.playbackEventStream.listen((event) {
      if (!mounted) return;
      setState(() {
        _total = event.duration ?? Duration.zero;
      });
    });

    _player.playerStateStream.listen((state) {
      if (!mounted) return;
      if (state.processingState == ProcessingState.completed) {
        _player.seek(Duration.zero);
        _player.pause();
      }
    });
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  Future<void> _playAudio(String url, int index) async {
    try {
      if (_playingIndex == index && _player.playing) {
        await _player.pause();
        setState(() {});
        return;
      }

      if (_playingIndex == index && !_player.playing) {
        await _player.play();
        setState(() {});
        return;
      }

      setState(() {
        _isLoading = true;
        _playingIndex = index;
        _total = Duration.zero;
      });

      await _player.stop();
      await _player.setUrl(url);

      Duration? totalDuration;
      int tries = 0;
      while (totalDuration == null && tries < 10) {
        await Future.delayed(const Duration(milliseconds: 100));
        totalDuration = _player.duration;
        tries++;
      }

      setState(() {
        _total = totalDuration ?? Duration.zero;
        _isLoading = false;
      });

      await _player.play();
    } catch (e) {
      debugPrint("Audio error: $e");
      setState(() {
        _isLoading = false;
        _playingIndex = null;
      });
    }
  }

  String _format(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    final allItems = widget.audiosummery ?? [];
    final audioList = allItems.where((item) => item.docTypeID == 6).toList();
    if (audioList.isEmpty) {
      return SizedBox();
    }

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: AppColors.hint2color.withAlpha(1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          Text(
            "Audio Summary",
            style: AppFonts.hinttext2.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: audioList.length,
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final audio = audioList[index];
              final isSelected = _playingIndex == index;

              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.primarycolor),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset('assets/svg/audio.svg', width: 30),
                    const SizedBox(width: 10),

                    /// --- AUDIO DETAILS COLUMN ---
                    Expanded(
                      child: StreamBuilder<Duration>(
                        stream: _player.positionStream,
                        builder: (context, snapshot) {
                          final current =
                              isSelected
                                  ? snapshot.data ?? Duration.zero
                                  : Duration.zero;
                          final total = isSelected ? _total : Duration.zero;
                          final progress =
                              total.inMilliseconds > 0
                                  ? current.inMilliseconds /
                                      total.inMilliseconds
                                  : 0.0;

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                audio.fileName,
                                style: AppFonts.subheading16.copyWith(
                                  fontSize: 14,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 6),

                              /// --- SMOOTH PROGRESS BAR ---
                              TweenAnimationBuilder<double>(
                                tween: Tween<double>(
                                  begin: 0.0,
                                  end: progress.clamp(0.0, 1.0),
                                ),
                                duration: const Duration(milliseconds: 200),
                                builder: (context, value, child) {
                                  return LinearProgressIndicator(
                                    value: value,
                                    backgroundColor: AppColors.hint2color
                                        .withAlpha(90),
                                    valueColor: AlwaysStoppedAnimation(
                                      AppColors.primarycolor,
                                    ),
                                    minHeight: 5,
                                  );
                                },
                              ),
                              const SizedBox(height: 6),

                              /// --- DURATION DISPLAY ---
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    _format(current),
                                    style: AppFonts.textappbar.copyWith(
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    _format(total),
                                    style: AppFonts.textappbar.copyWith(
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      ),
                    ),

                    const SizedBox(width: 12),

                    /// --- PLAY / PAUSE BUTTON ---
                    ElevatedButton(
                      onPressed: () => _playAudio(audio.url, index),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primarycolor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (_isLoading && _playingIndex == index)
                            SizedBox(
                              height: 16,
                              width: 16,
                              child: CircularProgressIndicator(
                                color: AppColors.white,
                                strokeWidth: 2,
                              ),
                            )
                          else
                            StreamBuilder<PlayerState>(
                              stream: _player.playerStateStream,
                              builder: (context, snapshot) {
                                final isPlaying =
                                    snapshot.data?.playing ?? false;
                                final isCurrent = _playingIndex == index;
                                return Icon(
                                  (isPlaying && isCurrent)
                                      ? Icons.pause
                                      : Icons.play_arrow,
                                  color: AppColors.white,
                                  size: 20,
                                );
                              },
                            ),
                          const SizedBox(width: 4),
                          Text(
                            (isSelected && _player.playing) ? 'Pause' : 'Play',
                            style: AppFonts.textwhite.copyWith(fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
