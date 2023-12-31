import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:tune_pulse/app/modules/tracklist_view/domain/providers/tracklist_providers.dart';

class PlayMusickNotifier extends ChangeNotifier {
  PlayMusickNotifier();
  final AudioPlayer _player = AudioPlayer();
  Duration? currentDuration, currentPosition;
  double seekbarValue = 0;
  bool isPlaying = false;

  AudioPlayer get player => _player;

  void init(String preview, WidgetRef ref) {
    _player.setUrl(preview);
    _player.durationStream.listen((duration) {
      currentDuration = duration;
      notifyListeners();
    });
    _player.positionStream.listen((position) {
      currentPosition = position;
      if (currentDuration != null) {
        if (currentDuration! <= currentPosition!) {
          onStop();
          ref
              .read(selectedTrackNotifierProvider.notifier)
              .selectedTrack(ref: ref, isSelected: false);
        }
        double val = position.inMilliseconds.toDouble() /
            currentDuration!.inMilliseconds.toDouble();
        if (val > 0 && val < 1) {
          seekbarValue = val;
        }
      }

      notifyListeners();
    });

    onPlay();
  }

  onPlay() {
    try {
      if (isPlaying) {
        _player.pause();
      } else {
        _player.play();
      }
      isPlaying = !isPlaying;
      notifyListeners();
    } catch (e) {
      throw ('No Error in onPlay');
    }
  }

  onStop() {
    try {
      player.stop();
      isPlaying = false;
      currentDuration = Duration.zero;
      currentPosition = Duration.zero;
      notifyListeners();
    } catch (e) {
      throw ('No Error in onStop');
    }
  }

  changeSeekbar(double value) {
    if (currentDuration != null) {
      seekbarValue = value;
      player.seek(Duration(
          milliseconds:
              (value * currentDuration!.inMilliseconds.toDouble()).toInt()));
    }

    notifyListeners();
  }

  bool get isLoaded =>
      _player.processingState == ProcessingState.ready ||
      _player.processingState == ProcessingState.completed ||
      _player.processingState == ProcessingState.buffering;
}
