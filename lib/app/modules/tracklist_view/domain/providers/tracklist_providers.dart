import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tune_pulse/app/modules/tracklist_view/domain/providers/controller/play_music_notifer.dart';
import 'package:tune_pulse/app/modules/tracklist_view/domain/providers/controller/selected_track_state.dart';
import 'package:tune_pulse/app/modules/tracklist_view/domain/providers/controller/trackist_notifier.dart';
import 'package:tune_pulse/app/modules/tracklist_view/domain/providers/state/selected_track_state.dart';
import 'package:tune_pulse/app/modules/tracklist_view/domain/providers/state/tracklist_state.dart';
import 'package:tune_pulse/app/modules/tracklist_view/domain/repo/track_list_repo.dart';

final lessonsRepoProvider =
    Provider<TrackListRepository>((ref) => TrackListRepository());

final playlistStateNotifierProvider =
    StateNotifierProvider.autoDispose<TrackListStateNotifier, TrackListState>(
        (ref) => TrackListStateNotifier(
              TrackListState(),
              ref.read(lessonsRepoProvider),
            ));

final selectedTrackNotifierProvider = StateNotifierProvider.autoDispose<
    SelectedTrackNotifier, SelectedTrackState>(
  (ref) => SelectedTrackNotifier(),
);

final playMusicNotifierProvider = ChangeNotifierProvider<PlayMusickNotifier>(
  (ref) => PlayMusickNotifier(),
);
