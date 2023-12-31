import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';
import 'package:tune_pulse/app/core/constants/my_app_colors.dart';
import 'package:tune_pulse/app/modules/tracklist_view/domain/models/track_model.dart';
import 'package:tune_pulse/app/modules/tracklist_view/domain/providers/tracklist_providers.dart';
import 'package:tune_pulse/app/utils/music_progres_value.dart';
import 'package:tune_pulse/app/utils/track_helper.dart';

class TrackTimerSlider extends ConsumerWidget
    with TrackHelpers, HelperMusicProgressValue {
  const TrackTimerSlider({
    super.key,
    required this.track,
  });

  final Track track;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final musicPlayerController = ref.read(playMusicNotifierProvider.notifier);
    final musicPlayerState = ref.watch(playMusicNotifierProvider);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.5.h),
      child: Row(
        children: [
          Text(convertSecondsToMinSec(musicPlayerState.seekbarValue.toInt())),
          Expanded(
            child: Slider(
              min: 0,
              max: 1,
              value: musicPlayerState.seekbarValue,
              activeColor: MyColors.secondary_500,
              inactiveColor: MyColors.greyscale_500,
              onChanged: musicPlayerController.changeSeekbar,
            ),
          ),
          Text(convertSecondsToMinSec(track.duration)),
        ],
      ),
    );
  }
}
