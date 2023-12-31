// Import necessary libraries
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';
import 'package:tune_pulse/app/modules/tracklist_view/domain/providers/tracklist_providers.dart';

// Widget to display an animated waveform that visualizes audio playback
class AudioWaveAnimation extends ConsumerStatefulWidget {
  const AudioWaveAnimation({super.key});

  @override
  ConsumerState createState() => AudioWaveAnimationState();
}

class AudioWaveAnimationState extends ConsumerState<AudioWaveAnimation>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1), // Animation duration
    )..repeat(); // Continuously repeat the animation
  }

  @override
  void dispose() {
    _controller
        .dispose(); // Dispose of the animation controller when widget is removed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Visibility(
        visible: ref
            .watch(playMusicNotifierProvider)
            .isPlaying, // Show only when music is playing
        child: AnimatedBuilder(
          animation:
              _controller, // Use AnimatedBuilder to synchronize with animation
          builder: (context, child) {
            return CustomPaint(
              painter: WaveformPainter(
                  _controller.value), // Pass animation value to painter
              size: Size(100.w, 100),
            );
          },
        ),
      ),
    );
  }
}

// Custom painter to draw the waveform
class WaveformPainter extends CustomPainter {
  final double animationValue; // Value from the animation controller

  WaveformPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2.0;

    const int totalPoints = 100; // Number of points for smooth wave
    final double width = size.width / totalPoints;
    final double height = size.height;

    for (int i = 0; i < totalPoints; i++) {
      final double x = i * width;
      final double midY = height / 2;
      final double maxAmplitude = height / 4; // Adjust for desired wave height
      final double sineHeight = maxAmplitude *
          sin(animationValue * 2 * pi +
              i); // Calculate wave height using sine function
      final double y = midY + sineHeight;

      canvas.drawLine(
          Offset(x, midY), Offset(x, y), paint); // Draw each wave segment
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true; // Always repaint to ensure smooth animation
  }
}
