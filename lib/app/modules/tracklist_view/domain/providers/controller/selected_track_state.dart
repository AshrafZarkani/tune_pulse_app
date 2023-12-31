// Import necessary libraries
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tune_pulse/app/modules/tracklist_view/domain/models/track_model.dart';
import 'package:tune_pulse/app/modules/tracklist_view/domain/providers/state/selected_track_state.dart';
import 'package:tune_pulse/app/modules/tracklist_view/domain/providers/tracklist_providers.dart';

// Class for managing the selected track state using a StateNotifier
class SelectedTrackNotifier extends StateNotifier<SelectedTrackState> {
  // Constructor to initialize the state
  SelectedTrackNotifier([SelectedTrackState? state])
      : super(state ?? SelectedTrackState());

  // Method to update the selected track state
  selectedTrack({
    Track? track,
    required WidgetRef ref,
    bool? isSelected,
  }) {
    if (track != null) {
      // Update the state with the new track and isSelected flag
      state = state.copyWith(
        isSelected: isSelected ?? !state.isSelected,
        track: track,
      );

      // If the track is no longer selected, stop playback
      if (state.isSelected == false) {
        ref.read(playMusicNotifierProvider).onPlay();
      }
    }
  }
}
