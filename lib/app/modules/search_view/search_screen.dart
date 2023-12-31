import 'package:flutter/material.dart';
import 'package:tune_pulse/app/core/constants/my_app_colors.dart';
import 'package:tune_pulse/app/core/extensions/build_context_x.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Text(
        "Search",
        style:
            context.textTheme.bodyLarge?.copyWith(color: MyColors.othersWhite),
      )),
    );
  }
}
