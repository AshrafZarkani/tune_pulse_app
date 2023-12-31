// Import necessary libraries
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';
import 'package:tune_pulse/app/core/constants/my_app_colors.dart';
import 'package:tune_pulse/app/modules/tracklist_view/domain/models/track_model.dart';
import 'package:tune_pulse/app/modules/tracklist_view/domain/providers/tracklist_providers.dart';
import 'package:tune_pulse/app/utils/music_progres_value.dart';
import 'package:tune_pulse/app/utils/track_helper.dart';

// Widget to display a track timer and seekbar for controlling music playback
class TrackTimerSlider extends ConsumerWidget
    with TrackHelpers, HelperMusicProgressValue {
  const TrackTimerSlider({
    super.key,
    required this.track,
  });

  final Track track; // Track model for reference

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final musicPlayerController = ref.read(playMusicNotifierProvider.notifier);
    final musicPlayerState = ref.watch(playMusicNotifierProvider);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.5.h), // Horizontal padding
      child: Row(
        children: [
          // Current playback time
          Text(
            convertSecondsToMinSec(musicPlayerState.seekbarValue.toInt()),
            // Using convertSecondsToMinSec for formatting
          ),
          Expanded(
            child: Slider(
              min: 0,
              max: 1, // Normalized seekbar value
              value: musicPlayerState.seekbarValue, // Current position
              activeColor: MyColors.secondary_500, // Active color
              inactiveColor: MyColors.greyscale_500, // Inactive color
              onChanged:
                  musicPlayerController.changeSeekbar, // Update on change
            ),
          ),
          // Total track duration
          Text(convertSecondsToMinSec(track.duration)),
        ],
      ),
    );
  }
}
