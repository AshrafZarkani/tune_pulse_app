import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tune_pulse/app/core/constants/my_app_colors.dart';
import 'package:tune_pulse/app/modules/tracklist_view/domain/models/track_model.dart';
import 'package:tune_pulse/app/modules/tracklist_view/domain/providers/tracklist_providers.dart';

class LinearMusicProgressIndicator extends ConsumerStatefulWidget {
  const LinearMusicProgressIndicator({Key? key, this.track}) : super(key: key);

  final Track? track;

  @override
  ConsumerState<LinearMusicProgressIndicator> createState() =>
      _LinearMusicProgressIndicatorState();
}

class _LinearMusicProgressIndicatorState
    extends ConsumerState<LinearMusicProgressIndicator> {
  @override
  void initState() {
    super.initState();
    final track = widget.track;
    if (track != null) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        final url = track.preview;
        if (context.mounted) {
          ref.read(playMusicNotifierProvider.notifier).init(url, ref);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final playMusicProvider = ref.watch(playMusicNotifierProvider);

    return LinearProgressIndicator(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(4),
        bottomRight: Radius.circular(4),
      ),
      value: playMusicProvider.seekbarValue,
      color: MyColors.secondary_500,
      backgroundColor: Colors.transparent,
    );
  }
}
