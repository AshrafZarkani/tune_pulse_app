import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import 'package:tune_pulse/app/core/constants/my_app_colors.dart';
import 'package:tune_pulse/app/core/extensions/build_context_x.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
    this.leadingTrue = false,
    this.color = MyColors.othersWhite,
    this.backgroundColor = MyColors.primary_500,
    this.fontSize,
    this.appBarTitle = "",
    this.fontWeight = FontWeight.w600,
    this.showTitleArrow = false,
    this.leadingCallBack,
    this.actions,
    this.centerTitle,
  }) : super(key: key);

  final bool leadingTrue;
  final Color color;
  final Color backgroundColor;
  final double? fontSize;
  final FontWeight fontWeight;
  final String appBarTitle;
  final bool showTitleArrow;
  final Function()? leadingCallBack;
  final List<Widget>? actions;
  final bool? centerTitle;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: leadingTrue
          ? IconButton(
              onPressed: leadingCallBack ?? () => context.pop(),
              icon: const Icon(
                Icons.arrow_back,
                color: MyColors.othersWhite,
              ),
            )
          : null,
      scrolledUnderElevation: 0.0,
      actions: actions,
      backgroundColor: backgroundColor,
      centerTitle: centerTitle ?? false,
      title: Text(
        appBarTitle,
        style: context.textTheme.titleLarge?.copyWith(
          color: color,
          fontSize: fontSize ?? 15.sp,
          fontWeight: fontWeight,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(7.h);
}
