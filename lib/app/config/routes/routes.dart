import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tune_pulse/app/config/routes/named_routes.dart';
import 'package:tune_pulse/app/modules/navbar/view/navbar_screen.dart';
import 'package:tune_pulse/app/modules/track_details/view/track_details.dart';
import 'package:tune_pulse/app/modules/tracklist_view/domain/models/track_model.dart';
import 'package:tune_pulse/app/modules/tracklist_view/view/tracklist_screen.dart';
import 'package:tune_pulse/app/modules/podcasts_view/podcasts_screen.dart';
import 'package:tune_pulse/app/modules/search_view/search_screen.dart';
import 'package:tune_pulse/app/modules/settings_view/settings_screen.dart';
import 'package:tune_pulse/app/modules/splash/splash_screen.dart';

import '../../modules/navbar/widgets/barrel_home_widgets.dart';

///[rootNavigatorKey] used for global | general navigation
final rootNavigatorKey = GlobalKey<NavigatorState>();

///[shellNavigatorKey] used for nesting routes within bottom nav bar (stickey bottom nav bar)
final shellNavigatorKey = GlobalKey<NavigatorState>();

abstract class AppRouter {
  static Widget errorWidget(BuildContext context, GoRouterState state) =>
      const SizedBox();

  /// use this in [MaterialApp.router]
  static final _router = GoRouter(
    initialLocation: MyNamedRoutes.root,
    navigatorKey: rootNavigatorKey,
    debugLogDiagnostics: true,
    routes: [
      // outside the [ShellRoute] to make the screen on top of the [BottomNavBar]
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: MyNamedRoutes.root,
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: const SplashScreen(),
        ),
      ),
      ShellRoute(
        navigatorKey: shellNavigatorKey,
        builder: (context, state, child) {
          return ScaffoldWithBottomNavBar(
            tabs: BottomNavBarTabs.tabs(context),
            child: child,
          );
        },
        routes: [
          //messages
          GoRoute(
            path: "/${MyNamedRoutes.home}",
            name: MyNamedRoutes.home,
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: animation.drive(CurveTween(curve: Curves.easeIn)),
                  child: child,
                );
              },
              child: const PLayListScreen(),
            ),
          ),
          // search
          GoRoute(
            path: "/${MyNamedRoutes.search}",
            name: MyNamedRoutes.search,
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: animation.drive(CurveTween(curve: Curves.easeIn)),
                  child: child,
                );
              },
              child: const SearchScreen(),
            ),
          ),
          // podcasts
          GoRoute(
            path: "/${MyNamedRoutes.podcasts}",
            name: MyNamedRoutes.podcasts,
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: animation.drive(CurveTween(curve: Curves.easeIn)),
                  child: child,
                );
              },
              child: const PodcastsScreen(),
            ),
          ),
          //settings
          GoRoute(
            path: "/${MyNamedRoutes.settings}",
            name: MyNamedRoutes.settings,
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: animation.drive(CurveTween(curve: Curves.easeIn)),
                  child: child,
                );
              },
              child: const SettingsScreen(),
            ),
          ),
        ],
      ),
      GoRoute(
          path: "/${MyNamedRoutes.trackDetails}",
          name: MyNamedRoutes.trackDetails,
          pageBuilder: (context, state) => CustomTransitionPage(
                key: state.pageKey,
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity: animation.drive(CurveTween(curve: Curves.easeIn)),
                    child: child,
                  );
                },
                child: TrackDetails(
                  track: state.extra as Track,
                ),
              )),
    ],
    errorBuilder: errorWidget,
  );

  static GoRouter get router => _router;
}
