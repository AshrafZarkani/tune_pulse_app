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
  /// Define a stateful widget for a scaffold with a bottom navigation bar
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
    extends ConsumerState<ScaffoldWithBottomNavBar>
    with TickerProviderStateMixin {
  /// Animation controller for the bottom bar indicator
  late AnimationController _controller;
  late Animation<double> _animation;
  int currentIndex = 0;

  /// Initialize animation controller during state initialization
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = Tween<double>(
      begin: 0.0,
      end: 0.0,
    ).animate(_controller);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateAnimationValue();
    });
  }

  /// Update animation values based on screen size and current tab index
  void _updateAnimationValue() {
    setState(() {
      _animation = Tween<double>(
        begin: 0.0,
        end: MediaQuery.of(context).size.width / widget.tabs.length * 0.3,
      ).animate(_controller);
      _controller.value = currentIndex.toDouble();
    });
  }

  /// Calculate the selected index based on the current route
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

  /// Handle tab tap events
  void _onItemTapped(int index, BuildContext context) {
    setState(() {
      currentIndex = index;
    });
    _controller.reset();
    _controller.forward();

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
          bottomNavigationBar: Stack(
            children: [
              Theme(
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
              Positioned(
                bottom: 60,
                child: AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      alignment: Alignment.bottomCenter,
                      height: 3.0,
                      width: _animation.value,
                      margin: EdgeInsets.only(
                        left: (currentIndex *
                                (MediaQuery.of(context).size.width /
                                    widget.tabs.length)) +
                            30,
                      ),
                      decoration: BoxDecoration(
                        color: MyColors.secondary_500,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    );
                  },
                ),
              ),
            ],
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
