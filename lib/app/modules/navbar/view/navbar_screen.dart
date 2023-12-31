import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import 'package:tune_pulse/app/config/routes/named_routes.dart';
import 'package:tune_pulse/app/core/extensions/build_context_x.dart';
import 'package:tune_pulse/app/modules/navbar/widgets/tab_bar_item.dart';
import 'package:tune_pulse/app/modules/tracklist_view/widgets/music_playing_card_stack.dart';

import '../../../core/constants/barrel_constants.dart';

class ScaffoldWithBottomNavBar extends ConsumerStatefulWidget {
  const ScaffoldWithBottomNavBar(
      {Key? key, required this.child, required this.tabs})
      : super(key: key);
  final Widget child;
  final List<ScaffoldWithNavBarTabItem> tabs;

  @override
  ConsumerState<ScaffoldWithBottomNavBar> createState() =>
      _ScaffoldWithBottomNavBarState();
}

class _ScaffoldWithBottomNavBarState
    extends ConsumerState<ScaffoldWithBottomNavBar> {
  static int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).matchedLocation;
    if (location.startsWith('/${MyNamedRoutes.home}')) {
      return 0;
    }
    if (location.startsWith('/${MyNamedRoutes.search}')) {
      return 1;
    }
    if (location.startsWith('/${MyNamedRoutes.podcasts}')) {
      return 3;
    }
    if (location.startsWith('/${MyNamedRoutes.settings}')) {
      return 4;
    }
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        GoRouter.of(context).go('/${MyNamedRoutes.home}');
        break;
      case 1:
        GoRouter.of(context).go('/${MyNamedRoutes.search}');
        break;
      case 2:
        break;
      case 3:
        GoRouter.of(context).go('/${MyNamedRoutes.podcasts}');
        break;
      case 4:
        GoRouter.of(context).go('/${MyNamedRoutes.settings}');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: widget.child,
          bottomNavigationBar: Theme(
            data: ThemeData(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            child: BottomNavigationBar(
              backgroundColor: MyColors.primary_800,
              elevation: 0,
              currentIndex: _calculateSelectedIndex(context),
              items: widget.tabs,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: MyColors.secondary_500,
              showUnselectedLabels: true,
              unselectedItemColor: MyColors.othersWhite,
              selectedIconTheme:
                  const IconThemeData(color: MyColors.secondary_500),
              unselectedIconTheme:
                  const IconThemeData(color: MyColors.othersWhite),
              selectedLabelStyle: context.textTheme.bodyMedium
                  ?.copyWith(color: MyColors.secondary_500),
              unselectedLabelStyle: context.textTheme.bodyMedium
                  ?.copyWith(color: MyColors.primary_500),
              onTap: (index) => _onItemTapped(index, context),
            ),
          ),
        ),
        Positioned(
          bottom: 14.h,
          left: 2.h,
          right: 2.h,
          child: const MusicPlayingCard(),
        ),
      ],
    );
  }
}
