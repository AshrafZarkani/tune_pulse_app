import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tune_pulse/app/config/barrel_config.dart';
import 'package:tune_pulse/app/core/constants/my_app_colors.dart';
import 'package:tune_pulse/app/core/extensions/build_context_x.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedTextKit(
          animatedTexts: [
            TypewriterAnimatedText(
              'TunePulse',
              textStyle: context.textTheme.displayMedium
                  ?.copyWith(color: MyColors.secondary_500),
              speed: const Duration(milliseconds: 200),
            ),
          ],
          totalRepeatCount: 1,
          pause: const Duration(milliseconds: 500),
          displayFullTextOnTap: true,
          stopPauseOnTap: true,
          onFinished: () {
            context.goNamed(MyNamedRoutes.home);
          },
        ),
      ),
    );
  }
}
