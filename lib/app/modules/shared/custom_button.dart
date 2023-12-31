import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:tune_pulse/app/core/constants/my_app_colors.dart';
import 'package:tune_pulse/app/core/extensions/build_context_x.dart';

class CustomButton extends StatelessWidget {
  final double height;
  final VoidCallback? onPressed;
  final bool enabled;
  final String text;
  final double fontSize;
  final bool loading;
  final Widget? textIcon;
  final Color? buttonColor;
  final Color borderColor;

  const CustomButton(
    this.text, {
    Key? key,
    this.height = 60,
    this.enabled = false,
    this.onPressed,
    this.loading = false,
    this.fontSize = 16,
    this.textIcon,
    this.buttonColor,
    this.borderColor = MyColors.othersWhite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2.h),
      height: height,
      decoration: BoxDecoration(
        color: buttonColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              side: BorderSide(color: borderColor),
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
          minimumSize: MaterialStateProperty.all(
              Size(context.screenWidth - 40, context.screenHeight)),
        ),
        onPressed: enabled ? onPressed : null,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 10,
            bottom: 10,
          ),
          child: loading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: MyColors.othersWhite,
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (textIcon != null) textIcon!,
                    Visibility(
                      visible: textIcon != null,
                      child: const SizedBox(
                        width: 6,
                      ),
                    ),
                    Text(
                      text,
                      style: TextStyle(
                        fontSize: fontSize,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
