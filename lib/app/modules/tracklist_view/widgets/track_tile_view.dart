import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import 'package:tune_pulse/app/config/barrel_config.dart';
import 'package:tune_pulse/app/core/constants/assets_path.dart';
import 'package:tune_pulse/app/core/constants/my_app_colors.dart';
import 'package:tune_pulse/app/core/extensions/build_context_x.dart';
import 'package:tune_pulse/app/modules/tracklist_view/domain/models/track_model.dart';
import 'package:tune_pulse/app/modules/tracklist_view/domain/providers/tracklist_providers.dart';
import 'package:tune_pulse/app/utils/track_helper.dart';

class TrackTileView extends ConsumerWidget with TrackHelpers {
  const TrackTileView({Key? key, this.track}) : super(key: key);

  final Track? track;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTrackState = ref.watch(selectedTrackNotifierProvider);
    final musicPlaying = ref.watch(playMusicNotifierProvider);
    final selectedTrackController =
        ref.read(selectedTrackNotifierProvider.notifier);
    bool showSelectionDesign =
        musicPlaying.isPlaying && selectedTrackState.track?.id == track?.id;
    return Container(
      decoration: showSelectionDesign
          ? BoxDecoration(
              color: MyColors.greyscale_500.withOpacity(0.2),
              borderRadius: BorderRadius.circular(11))
          : null,
      padding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.h),
      child: Row(
        children: [
          RawMaterialButton(
            onPressed: () {
              musicPlaying.onPlay();
              selectedTrackController.selectedTrack(
                track: track,
                ref: ref,
                isSelected: true,
              );
            },
            elevation: 1.0,
            fillColor: showSelectionDesign
                ? MyColors.secondary_500
                : MyColors.othersWhite,
            constraints: BoxConstraints(minWidth: 4.h, minHeight: 4.h),
            padding: EdgeInsets.zero,
            shape: const CircleBorder(),
            child: SvgPicture.asset(
              showSelectionDesign
                  ? MyAssetsPath.svgPause
                  : MyAssetsPath.svgPlay,
              height: showSelectionDesign ? 1.5.h : 1.2.h,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(
            width: 1.h,
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                rootNavigatorKey.currentState!.context
                    .pushNamed(MyNamedRoutes.trackDetails, extra: track)
                    .then((value) {
                  selectedTrackController.selectedTrack(
                    track: track,
                    ref: ref,
                  );
                });
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(track?.titleShort.toString() ?? "",
                      style: context.textTheme.bodyLarge
                          ?.copyWith(fontWeight: FontWeight.bold)),
                  Padding(
                    padding: EdgeInsets.only(top: 1.h),
                    child: Text(track?.artist.name.toString() ?? "",
                        style: context.textTheme.bodySmall),
                  ),
                ],
              ),
            ),
          ),
          Text(convertSecondsToMinSec(track?.duration ?? 0),
              style: context.textTheme.bodySmall)
        ],
      ),
    );
  }
}
