import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';
import 'package:tune_pulse/app/core/constants/my_app_colors.dart';
import 'package:tune_pulse/app/core/extensions/build_context_x.dart';
import 'package:tune_pulse/app/modules/tracklist_view/domain/models/track_model.dart';
import 'package:tune_pulse/app/modules/tracklist_view/domain/providers/tracklist_providers.dart';
import 'package:tune_pulse/app/modules/tracklist_view/widgets/track_tile_view.dart';
import 'package:very_good_infinite_list/very_good_infinite_list.dart';

class PlaylistBody extends ConsumerWidget {
  /// Paginated track list
  const PlaylistBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playlistState = ref.watch(playlistStateNotifierProvider);
    final playListController = ref.read(playlistStateNotifierProvider.notifier);

    return InfiniteList(
      itemCount: playlistState.playList?.length ?? 0,
      onFetchData: () => playListController.getPlayList(),
      isLoading: playlistState.isLoading,
      hasError: playlistState.error != null,
      loadingBuilder: (context) => Center(
        child: SizedBox(
          height: 2.h,
          width: 2.h,
          child: const CircularProgressIndicator(
            color: MyColors.secondary_500,
          ),
        ),
      ),
      centerError: true,
      hasReachedMax: playlistState.hasReachedMax,
      itemBuilder: (BuildContext context, int index) {
        final Track? track = playlistState.playList?[index];
        return TrackTileView(track: track);
      },
      emptyBuilder: (context) => Center(
          child: Text(
        "No Data",
        style: context.textTheme.bodyMedium,
      )),
    );
  }
}
