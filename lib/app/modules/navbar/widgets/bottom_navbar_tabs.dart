import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import 'package:tune_pulse/app/modules/navbar/widgets/tab_bar_item.dart';

import '../../../config/barrel_config.dart';
import '../../../core/constants/barrel_constants.dart';

///[BottomNavBarTabs] custome bottom nabe bar items class
abstract class BottomNavBarTabs {
  static List<ScaffoldWithNavBarTabItem> tabs(BuildContext context) {
    return [
      ScaffoldWithNavBarTabItem(
        initialLocation: MyNamedRoutes.home,
        icon: Padding(
          padding: EdgeInsets.symmetric(vertical: 0.5.h),
          child: SvgPicture.asset(MyAssetsPath.svgHome),
        ),
        activeIcon: Padding(
          padding: EdgeInsets.symmetric(vertical: 0.5.h),
          child: SvgPicture.asset(
            MyAssetsPath.svgHome,
            colorFilter: const ColorFilter.mode(
              MyColors.othersWhite,
              BlendMode.srcIn,
            ),
            height: 3.h,
            width: 3.h,
          ),
        ),
      ),
      ScaffoldWithNavBarTabItem(
        initialLocation: MyNamedRoutes.search,
        icon: Padding(
          padding: EdgeInsets.symmetric(vertical: 0.5.h),
          child: SvgPicture.asset(
            MyAssetsPath.svgSearch,
            height: 2.h,
            width: 2.h,
          ),
        ),
        activeIcon: Padding(
          padding: EdgeInsets.symmetric(vertical: 0.5.h),
          child: SvgPicture.asset(
            MyAssetsPath.svgSearch,
            colorFilter: const ColorFilter.mode(
              MyColors.othersWhite,
              BlendMode.srcIn,
            ),
            height: 3.h,
            width: 3.h,
          ),
        ),
      ),
      ScaffoldWithNavBarTabItem(
        initialLocation: "",
        icon: Padding(
          padding: EdgeInsets.symmetric(vertical: 0.5.h),
          child: ClipOval(
            child: Container(
              color: MyColors.secondary_500,
              height: 5.6.h,
              width: 5.6.h,
              child: const Icon(Icons.headphones),
            ),
          ),
        ),
        activeIcon: Padding(
          padding: EdgeInsets.symmetric(vertical: 0.5.h),
          child: ClipOval(
            child: Container(
              color: MyColors.secondary_500,
              height: 5.6.h,
              width: 5.6.h,
              child: const Icon(Icons.headphones),
            ),
          ),
        ),
      ),
      ScaffoldWithNavBarTabItem(
        initialLocation: MyNamedRoutes.podcasts,
        icon: Padding(
          padding: EdgeInsets.symmetric(vertical: 0.5.h),
          child: SvgPicture.asset(
            MyAssetsPath.svgPoscast,
            height: 2.h,
            width: 2.h,
          ),
        ),
        activeIcon: Padding(
          padding: EdgeInsets.symmetric(vertical: 0.5.h),
          child: SvgPicture.asset(
            MyAssetsPath.svgPoscast,
            colorFilter: const ColorFilter.mode(
              MyColors.othersWhite,
              BlendMode.srcIn,
            ),
            height: 3.h,
            width: 3.h,
          ),
        ),
      ),
      ScaffoldWithNavBarTabItem(
        initialLocation: MyNamedRoutes.settings,
        icon: Padding(
          padding: EdgeInsets.symmetric(vertical: 0.5.h),
          child: SvgPicture.asset(
            MyAssetsPath.svgSettings,
            height: 2.h,
            width: 2.h,
          ),
        ),
        activeIcon: Padding(
          padding: EdgeInsets.symmetric(vertical: 0.5.h),
          child: SvgPicture.asset(
            MyAssetsPath.svgSettings,
            colorFilter: const ColorFilter.mode(
              MyColors.othersWhite,
              BlendMode.srcIn,
            ),
            height: 3.h,
            width: 3.h,
          ),
        ),
      ),
    ];
  }
}
