import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';
import 'package:tune_pulse/app/modules/tracklist_view/domain/providers/tracklist_providers.dart';

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
      duration: const Duration(seconds: 1),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Visibility(
        visible: ref.watch(playMusicNotifierProvider).isPlaying,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return CustomPaint(
              painter: WaveformPainter(_controller.value),
              size: Size(100.w, 100),
            );
          },
        ),
      ),
    );
  }
}

class WaveformPainter extends CustomPainter {
  final double animationValue;

  WaveformPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2.0;

    const int totalPoints = 100;
    final double width = size.width / totalPoints;
    final double height = size.height;

    for (int i = 0; i < totalPoints; i++) {
      final double x = i * width;
      final double midY = height / 2;
      final double maxAmplitude = height / 4;
      final double sineHeight = maxAmplitude * sin(animationValue * 2 * pi + i);
      final double y = midY + sineHeight;

      canvas.drawLine(Offset(x, midY), Offset(x, y), paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
