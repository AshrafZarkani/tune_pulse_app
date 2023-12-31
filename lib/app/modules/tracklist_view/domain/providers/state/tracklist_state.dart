import 'package:tune_pulse/app/modules/tracklist_view/domain/models/track_model.dart';

class TrackListState {
  final bool isLoading;
  final String? error;
  final List<Track>? playList;
  final bool hasReachedMax;
  final int pageLimit;
  late int? index;

  TrackListState({
    this.isLoading = false,
    this.error,
    this.playList,
    this.hasReachedMax = false,
    this.index = 20,
    this.pageLimit = 20,
  });

  TrackListState copyWith({
    bool? isLoading,
    String? error,
    List<Track>? playList,
    bool? hasReachedMax,
    int? index,
    int? pageLimit,
  }) {
    return TrackListState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      playList: playList ?? this.playList,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      index: index ?? this.index,
      pageLimit: pageLimit ?? this.pageLimit,
    );
  }
}
