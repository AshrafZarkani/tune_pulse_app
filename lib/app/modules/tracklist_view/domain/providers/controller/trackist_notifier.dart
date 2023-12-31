// Import necessary libraries
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tune_pulse/app/modules/tracklist_view/domain/models/track_model.dart';
import 'package:tune_pulse/app/modules/tracklist_view/domain/providers/state/tracklist_state.dart';
import 'package:tune_pulse/app/modules/tracklist_view/domain/repo/track_list_repo.dart';

// Class for managing the track list state using a StateNotifier
class TrackListStateNotifier extends StateNotifier<TrackListState> {
  // Dependency on the track list repository
  final TrackListRepository lessonsRepository;

  // Constructor to initialize the state and repository
  TrackListStateNotifier(TrackListState state, this.lessonsRepository)
      : super(state);

  /// Method to fetch a paginated track list
  Future<void> getPlayList() async {
    if (state.isLoading || state.hasReachedMax) {
      // Do nothing if already loading or has reached the maximum
      return;
    }

    try {
      // Mark as loading
      state = state.copyWith(isLoading: true);

      // Fetch tracks from the repository
      List<Track> data = await lessonsRepository.repoGetTrackList(
        state.pageLimit,
        state.index!,
      );

      if (data.isEmpty) {
        // If no more tracks, mark as reached max
        state = state.copyWith(hasReachedMax: true, isLoading: false);
        return;
      }

      // Update state with fetched tracks
      debugPrint("call api getPlayList");
      state = state.copyWith(
        isLoading: false,
        playList: [...state.playList ?? [], ...data],
        index: state.index! + 20,
        hasReachedMax: data.length < 20 ? true : false,
      );
    } catch (e) {
      // Handle errors
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}
