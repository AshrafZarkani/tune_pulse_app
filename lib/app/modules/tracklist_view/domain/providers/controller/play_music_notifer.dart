// Import necessary libraries
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:tune_pulse/app/modules/tracklist_view/domain/providers/tracklist_providers.dart';

// Class for managing music playback using a ChangeNotifier
class PlayMusickNotifier extends ChangeNotifier {
  // Create an instance of the AudioPlayer
  PlayMusickNotifier();
  final AudioPlayer _player = AudioPlayer();

  // Track duration and position
  Duration? currentDuration, currentPosition;

  // Seekbar value (0 to 1)
  double seekbarValue = 0;

  // Playback state flag
  bool isPlaying = false;

  // Getter for the AudioPlayer instance
  AudioPlayer get player => _player;

  // Initialize the player with a preview URL and a WidgetRef
  void init(String preview, WidgetRef ref) {
    // Set the audio source URL
    _player.setUrl(preview);

    // Listen for changes in the audio duration
    _player.durationStream.listen((duration) {
      currentDuration = duration;
      notifyListeners(); // Notify listeners for UI updates
    });

    // Listen for changes in the audio position
    _player.positionStream.listen((position) {
      currentPosition = position;

      // Handle playback completion
      if (currentDuration != null && currentDuration! <= currentPosition!) {
        onStop();
        ref
            .read(selectedTrackNotifierProvider.notifier)
            .selectedTrack(ref: ref, isSelected: false);
        // Update seekbar value
        double val = position.inMilliseconds.toDouble() /
            currentDuration!.inMilliseconds.toDouble();
        if (val > 0 && val < 1) {
          seekbarValue = val;
        }
      }

      notifyListeners(); // Notify listeners for UI updates
    });

    // Start playback initially
    onPlay();
  }

  // Toggle playback (play or pause)
  void onPlay() {
    try {
      if (isPlaying) {
        _player.pause();
      } else {
        _player.play();
      }
      isPlaying = !isPlaying;
      notifyListeners(); // Notify listeners for UI updates
    } catch (e) {
      throw ('Error in onPlay: $e'); // Rethrow with a descriptive message
    }
  }

  // Stop playback
  void onStop() {
    try {
      player.stop();
      isPlaying = false;
      currentDuration = Duration.zero;
      currentPosition = Duration.zero;
      notifyListeners(); // Notify listeners for UI updates
    } catch (e) {
      throw ('Error in onStop: $e'); // Rethrow with a descriptive message
    }
  }

  // Change seekbar position and seek in the audio
  void changeSeekbar(double value) {
    if (currentDuration != null) {
      seekbarValue = value;
      player.seek(Duration(
          milliseconds:
              (value * currentDuration!.inMilliseconds.toDouble()).toInt()));
      notifyListeners(); // Notify listeners for UI updates
    }
  }

  // Check if the audio is loaded and ready for playback
  bool get isLoaded =>
      _player.processingState == ProcessingState.ready ||
      _player.processingState == ProcessingState.completed ||
      _player.processingState == ProcessingState.buffering;
}
