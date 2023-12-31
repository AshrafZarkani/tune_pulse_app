import 'package:flutter/material.dart';

/// Representation of a tab item in a [ScaffoldWithNavBar]
class ScaffoldWithNavBarTabItem extends BottomNavigationBarItem {
  /// Constructs an [ScaffoldWithNavBarTabItem].
  const ScaffoldWithNavBarTabItem({
    required Widget icon,
    required Widget activeIcon,
    String? label,
    required this.initialLocation,
  }) : super(icon: icon, label: "", activeIcon: activeIcon);

  /// The initial location/path
  final String initialLocation;
}
