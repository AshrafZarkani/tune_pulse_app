// Import necessary libraries
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import 'package:tune_pulse/app/core/constants/assets_path.dart';
import 'package:tune_pulse/app/core/constants/my_app_colors.dart';
import 'package:tune_pulse/app/modules/tracklist_view/domain/models/track_model.dart';
import 'package:tune_pulse/app/modules/tracklist_view/domain/providers/tracklist_providers.dart';

// Widget to display music control buttons within track details
class SDetailsControlButtons extends ConsumerStatefulWidget {
  const SDetailsControlButtons({
    super.key,
    required this.track, // Track model to control
  });

  final Track track;

  @override
  ConsumerState<SDetailsControlButtons> createState() =>
      _SDetailsControlButtonsState();
}

class _SDetailsControlButtonsState
    extends ConsumerState<SDetailsControlButtons> {


  @override
  Widget build(BuildContext context) {
    final musicPlayerController = ref.read(playMusicNotifierProvider.notifier);
    final musicPlayerState = ref.watch(playMusicNotifierProvider);

    return Row(
      mainAxisAlignment:
          MainAxisAlignment.center, // Center buttons horizontally
      children: [
        // Skip backward button
        SvgPicture.asset(MyAssetsPath.svgSkipBackward),
        SizedBox(width: 3.h), // Spacing between buttons
        // Rewind button
        SvgPicture.asset(MyAssetsPath.svgRewind),
        SizedBox(width: 3.h),
        // Play/pause button
        RawMaterialButton(
          onPressed: () {
            musicPlayerController.onPlay(); // Toggle play/pause on tap
          },
          elevation: 1.0, // Slight elevation for visual emphasis
          fillColor: MyColors.othersWhite, // Fill color
          constraints:
              BoxConstraints(minWidth: 9.h, minHeight: 9.h), // Size constraints
          padding: EdgeInsets.zero, // Remove default padding
          shape: const CircleBorder(), // Circular shape
          child: SvgPicture.asset(
            // Dynamically display play/pause icon based on state
            musicPlayerState.isPlaying
                ? MyAssetsPath.svgPause
                : MyAssetsPath.svgPlay,
            height: 3.h,
            color: MyColors.othersBlack,
            fit: BoxFit.fill,
          ),
        ),
        SizedBox(width: 3.h),
        // Skip forward button
        SvgPicture.asset(MyAssetsPath.svgskipForward),
        SizedBox(width: 3.h),
        // Fast forward button
        SvgPicture.asset(MyAssetsPath.svgFastForward),
      ],
    );
  }
}
