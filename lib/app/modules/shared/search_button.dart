

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import 'package:tune_pulse/app/core/constants/assets_path.dart';
import 'package:tune_pulse/app/core/constants/my_app_colors.dart';

class SearchButton extends StatelessWidget {
  const SearchButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 1.h),
      child: SvgPicture.asset(
        MyAssetsPath.svgSearch,
        colorFilter: const ColorFilter.mode(
          MyColors.othersWhite,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}