import 'package:flutter/material.dart';
import 'package:tune_pulse/app/core/constants/my_app_colors.dart';
import 'package:tune_pulse/app/core/extensions/build_context_x.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Text(
        "Settings",
        style:
            context.textTheme.bodyLarge?.copyWith(color: MyColors.othersWhite),
      )),
    );
  }
}
