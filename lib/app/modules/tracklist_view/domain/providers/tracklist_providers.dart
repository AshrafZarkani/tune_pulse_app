// Import necessary libraries
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tune_pulse/app/modules/tracklist_view/domain/providers/controller/play_music_notifer.dart';
import 'package:tune_pulse/app/modules/tracklist_view/domain/providers/controller/selected_track_state.dart';
import 'package:tune_pulse/app/modules/tracklist_view/domain/providers/controller/trackist_notifier.dart';
import 'package:tune_pulse/app/modules/tracklist_view/domain/providers/state/selected_track_state.dart';
import 'package:tune_pulse/app/modules/tracklist_view/domain/providers/state/tracklist_state.dart';
import 'package:tune_pulse/app/modules/tracklist_view/domain/repo/track_list_repo.dart';

// Provider for the track list repository
final lessonsRepoProvider =
    Provider<TrackListRepository>((ref) => TrackListRepository());

// StateNotifierProvider for managing the track list state, automatically disposed
final playlistStateNotifierProvider =
    StateNotifierProvider.autoDispose<TrackListStateNotifier, TrackListState>(
  (ref) => TrackListStateNotifier(
    // Initialize with an empty track list state
    TrackListState(),
    // Access the track list repository from the provider
    ref.read(lessonsRepoProvider),
  ),
);

// StateNotifierProvider for managing the selected track state, automatically disposed
final selectedTrackNotifierProvider = StateNotifierProvider.autoDispose<
    SelectedTrackNotifier, SelectedTrackState>(
  (ref) => SelectedTrackNotifier(),
);

// ChangeNotifierProvider for managing music playback
final playMusicNotifierProvider = ChangeNotifierProvider<PlayMusickNotifier>(
  (ref) => PlayMusickNotifier(),
);
