import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tune_pulse/app/modules/tracklist_view/domain/models/track_model.dart';
import 'package:tune_pulse/app/modules/tracklist_view/domain/providers/state/tracklist_state.dart';
import 'package:tune_pulse/app/modules/tracklist_view/domain/repo/track_list_repo.dart';

class TrackListStateNotifier extends StateNotifier<TrackListState> {
  final TrackListRepository lessonsRepository;

  TrackListStateNotifier(TrackListState state, this.lessonsRepository)
      : super(state);

  /// get paginated track list
  Future<void> getPlayList() async {
    if (state.isLoading || state.hasReachedMax) {
      return;
    }

    try {
      state = state.copyWith(isLoading: true);
      List<Track> data = await lessonsRepository.repoGetTrackList(
        state.pageLimit,
        state.index!,
      );

      if (data.isEmpty) {
        state = state.copyWith(hasReachedMax: true, isLoading: false);
        return;
      }

      debugPrint("call api getPlayList");
      state = state.copyWith(
        isLoading: false,
        playList: [...state.playList ?? [], ...data],
        index: state.index! + 20,
        hasReachedMax: data.length < 20 ? true : false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}
