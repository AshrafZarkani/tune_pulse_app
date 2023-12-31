import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tune_pulse/app/modules/tracklist_view/domain/models/track_model.dart';
import 'package:tune_pulse/app/modules/tracklist_view/domain/providers/state/selected_track_state.dart';
import 'package:tune_pulse/app/modules/tracklist_view/domain/providers/tracklist_providers.dart';
// import 'package:tune_pulse/app/modules/tracklist_view/domain/providers/tracklist_providers.dart';
// import 'package:tune_pulse/main.dart';

class SelectedTrackNotifier extends StateNotifier<SelectedTrackState> {
  SelectedTrackNotifier([SelectedTrackState? state])
      : super(state ?? SelectedTrackState());

  selectedTrack({
    Track? track,
    required WidgetRef ref,
    bool? isSelected,
  }) {
    if (track != null) {
      state = state.copyWith(
        isSelected: isSelected ?? !state.isSelected,
        track: track,
      );
      if (state.isSelected == false) {
        ref.read(playMusicNotifierProvider).onPlay();
      }
    }
  }
}
