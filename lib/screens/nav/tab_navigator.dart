import 'package:flutter/material.dart';
import 'package:yukti/config/custom_router.dart';
import 'package:yukti/screens/dashboard/dashboard_screen.dart';

import 'package:yukti/screens/gallery_screen.dart';
import 'package:yukti/screens/nav/bottom_nav_item_enum.dart';
import 'package:yukti/screens/profile_screen.dart';

class TabNavigator extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final BottomNavItem items;

  const TabNavigator({
    Key? key,
    required this.navigatorKey,
    required this.items,
  }) : super(key: key);

  static const String tabNavigatorRoot = '/';

  Map<String, WidgetBuilder> _routeBuilder() {
    return {tabNavigatorRoot: (context) => _getScreen(context, items)};
  }

  Widget _getScreen(BuildContext context, BottomNavItem item) {
    print(item);
    switch (item) {
      case BottomNavItem.dashbaord:
        return DashBoard();
      case BottomNavItem.gallery:
        return GalleryScreen();
      case BottomNavItem.profile:
        return ProfileScreen();
      default:
        return Scaffold();
    }
  }

  @override
  Widget build(BuildContext context) {
    final routeBuilders = _routeBuilder();
    return Navigator(
      key: navigatorKey,
      initialRoute: tabNavigatorRoot,
      onGenerateInitialRoutes: (_, initialRoute) {
        return [
          MaterialPageRoute(
            settings: RouteSettings(name: tabNavigatorRoot),
            builder: (context) => routeBuilders[initialRoute]!(context),
          )
        ];
      },
      onGenerateRoute: CustomRouter.onGenerateNestedRouter,
    );
  }
}
