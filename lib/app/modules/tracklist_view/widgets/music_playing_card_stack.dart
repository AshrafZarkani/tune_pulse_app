import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:sizer/sizer.dart';
import 'package:tune_pulse/app/core/constants/barrel_constants.dart';
import 'package:tune_pulse/app/modules/tracklist_view/domain/providers/tracklist_providers.dart';
import 'package:tune_pulse/app/modules/tracklist_view/widgets/linear_music_progress_indicator.dart';

class MusicPlayingCard extends ConsumerWidget {
  const MusicPlayingCard({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTrackState = ref.watch(selectedTrackNotifierProvider);
    final selectedTrackController =
        ref.read(selectedTrackNotifierProvider.notifier);

    return Material(
      color: Colors.transparent,
      child: Visibility(
        visible: selectedTrackState.isSelected,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GlassContainer(
              height: 7.5.h,
              width: 100.w,
              gradient: const LinearGradient(
                colors: [
                  Color.fromARGB(255, 75, 74, 74),
                  Color.fromARGB(255, 27, 27, 29),
                  Color.fromARGB(255, 27, 27, 29),
                  Color.fromARGB(255, 27, 27, 29),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderGradient: const LinearGradient(
                colors: [
                  MyColors.primary_800,
                  MyColors.primary_800,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              blur: 100.0,
              isFrostedGlass: true,
              shadowColor: Colors.black.withOpacity(0.20),
              alignment: Alignment.center,
              frostedOpacity: 0.12,
              borderRadius: BorderRadius.circular(4),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 1.h),
                child: Row(
                  children: [
                    // Leading artist image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        selectedTrackState.track?.artist.pictureSmall ?? "",
                        width: 5.5.h,
                        height: 5.5.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 0.5.h),
                    // Song title
                    Expanded(
                      child: Text(
                        selectedTrackState.track?.titleShort.toString() ?? "",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    const SizedBox(width: 10),
                    // Trailing pause/next buttons
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          onTap: () {
                            if (selectedTrackState.track != null) {
                              selectedTrackController.selectedTrack(
                                track: selectedTrackState.track,
                                ref: ref,
                              );
                            } else {
                              selectedTrackController.selectedTrack(
                                track: selectedTrackState.track,
                                ref: ref,
                              );
                            }
                          },
                          child: SvgPicture.asset(
                            ref.watch(playMusicNotifierProvider).isPlaying
                                ? MyAssetsPath.svgPause
                                : MyAssetsPath.svgPlay,
                            // ignore: deprecated_member_use
                            color: MyColors.othersWhite,
                            height: 2.5.h,
                            width: 2.5.h,
                            fit: BoxFit.fill,
                          ),
                        ),
                        SizedBox(
                          width: 2.5.h,
                        ),
                        SvgPicture.asset(
                          MyAssetsPath.svgNext,
                          height: 2.5.h,
                          width: 2.5.h,
                          fit: BoxFit.fill,
                        ),
                        SizedBox(
                          width: 1.5.h,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            LinearMusicProgressIndicator(track: selectedTrackState.track),
          ],
        ),
      ),
    );
  }
}
