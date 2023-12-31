import 'package:tune_pulse/app/modules/tracklist_view/domain/models/track_model.dart';

class SelectedTrackState {
  final bool isSelected;
  final Track? track;

  SelectedTrackState({
    this.isSelected = false,
    this.track,
  });

  SelectedTrackState copyWith({
    bool? isSelected,
    Track? track,
  }) {
    return SelectedTrackState(
      isSelected: isSelected ?? this.isSelected,
      track: track,
    );
  }
}
