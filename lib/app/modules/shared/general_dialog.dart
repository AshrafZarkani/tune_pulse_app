import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import 'package:tune_pulse/app/config/routes/named_routes.dart';
import 'package:tune_pulse/app/config/routes/routes.dart';
import 'package:tune_pulse/app/core/constants/my_app_colors.dart';
import 'package:tune_pulse/app/core/extensions/build_context_x.dart';

class GeneralAlertDialog {
  static showAlertDialog(String text,
      {Widget? content, bool? showActions, bool? navigateToLogin}) {
    if (Platform.isAndroid) {
      showDialog(
        barrierDismissible: false,
        context: rootNavigatorKey.currentState!.context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: content ?? Text(text),
            actions: <Widget>[
              if (showActions == null)
                TextButton(
                  onPressed: () {
                    if (navigateToLogin == true) {
                      rootNavigatorKey.currentState!.context
                          .goNamed(MyNamedRoutes.home);
                    }
                    context.pop();
                  },
                  child: Text(context.translate.ok),
                ),
            ],
          );
        },
      );
    } else {
      showCupertinoDialog(
          context: rootNavigatorKey.currentState!.context,
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
              content: content ?? Text(text),
              actions: <Widget>[
                if (showActions == null)
                  CupertinoDialogAction(
                    isDefaultAction: true,
                    child: Text(context.translate.ok),
                    onPressed: () {
                      if (navigateToLogin == true) {
                        rootNavigatorKey.currentState!.context
                            .goNamed(MyNamedRoutes.home);
                      }
                      context.pop();
                    },
                  ),
              ],
            );
          });
    }
  }

  /// show bottom sheet
  static showBottomSheet({
    required String title,
    required Material body,
    Material? button,
    required Null Function() onPop,
    bool? isScrollControlled,
    double? height,
  }) {
    showModalBottomSheet(
      isScrollControlled: isScrollControlled ?? false,
      isDismissible: false,
      enableDrag: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      context: rootNavigatorKey.currentState!.context,
      builder: (BuildContext context) {
        return SizedBox(
          height: height,
          child: Column(
            children: [
              ListTile(
                leading: const Text(""),
                title: Container(
                  width: 10.w,
                  height: 0.7.h,
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  decoration: BoxDecoration(
                      color: MyColors.greyscale_500,
                      borderRadius: BorderRadius.circular(10)),
                ),
                trailing: IconButton(
                    onPressed: onPop,
                    icon: Container(
                        height: 3.h,
                        width: 3.h,
                        decoration: BoxDecoration(
                            color: MyColors.greyscale_500,
                            borderRadius: BorderRadius.circular(90)),
                        child: const Icon(Icons.close))),
              ),
              Text(
                title,
                style: context.textTheme.titleMedium?.copyWith(
                    color: MyColors.secondary_500, fontWeight: FontWeight.w700),
              ),
              Expanded(child: body),
              button ??
                  const SizedBox(
                    height: 1,
                  ),
              SizedBox(
                height: 2.h,
              )
            ],
          ),
        );
      },
    );
  }
}
