import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import 'package:tune_pulse/app/core/constants/assets_path.dart';
import 'package:tune_pulse/app/core/constants/my_app_colors.dart';
import 'package:tune_pulse/app/modules/tracklist_view/domain/models/track_model.dart';
import 'package:tune_pulse/app/modules/tracklist_view/domain/providers/tracklist_providers.dart';

class SDetailsControlButtons extends ConsumerStatefulWidget {
  const SDetailsControlButtons({
    super.key,
    required this.track,
  });

  final Track track;

  @override
  ConsumerState<SDetailsControlButtons> createState() =>
      _SDetailsControlButtonsState();
}

class _SDetailsControlButtonsState
    extends ConsumerState<SDetailsControlButtons> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final url = widget.track.preview;
      if (url.isNotEmpty) {
        if (ref.read(playMusicNotifierProvider.notifier).isLoaded == false) {
          ref.read(playMusicNotifierProvider.notifier).init(url, ref);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final musicPlayerController = ref.read(playMusicNotifierProvider.notifier);
    final musicPlayerState = ref.watch(playMusicNotifierProvider);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(MyAssetsPath.svgSkipBackward),
        SizedBox(
          width: 3.h,
        ),
        SvgPicture.asset(MyAssetsPath.svgRewind),
        SizedBox(
          width: 3.h,
        ),
        RawMaterialButton(
          onPressed: () {
            musicPlayerController.onPlay();
          },
          elevation: 1.0,
          fillColor: MyColors.othersWhite,
          constraints: BoxConstraints(minWidth: 9.h, minHeight: 9.h),
          padding: EdgeInsets.zero,
          shape: const CircleBorder(),
          child: SvgPicture.asset(
            musicPlayerState.isPlaying
                ? MyAssetsPath.svgPause
                : MyAssetsPath.svgPlay,
            height: 3.h,
            color: MyColors.othersBlack,
            fit: BoxFit.fill,
          ),
        ),
        SizedBox(
          width: 3.h,
        ),
        SvgPicture.asset(MyAssetsPath.svgskipForward),
        SizedBox(
          width: 3.h,
        ),
        SvgPicture.asset(MyAssetsPath.svgFastForward),
      ],
    );
  }
}
