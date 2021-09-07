import 'package:flutter/material.dart';
import 'package:yukti/screens/announcements/announcements_screen.dart';

import '/screens/login/login_screen.dart';
import '/screens/nav/nav_screen.dart';

import '/screens/signup/signup_screen.dart';

import 'auth_wrapper.dart';

class CustomRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    print('Route: ${settings.name}');
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            settings: const RouteSettings(name: '/'),
            builder: (_) => Scaffold());

      case AuthWrapper.routeName:
        return AuthWrapper.route();

      case LoginScreen.routeName:
        return LoginScreen.route();

      case SignupScreen.routeName:
        return SignupScreen.route();

      case NavScreen.routeName:
        return NavScreen.route();

      case AnnouncemetScreen.routeName:
        return AnnouncemetScreen.route();

      default:
        return _errorRoute();
    }
  }

  static Route onGenerateNestedRouter(RouteSettings settings) {
    print('NestedRoute: ${settings.name}');
    switch (settings.name) {
      // case ProfileScreen.routeName:
      //   return ProfileScreen.route();
      // args: settings.arguments as ProfileScreenArgs);
      // case GalleryScreen.routeName:
      //   return GalleryScreen.route();
      // case DashBoard.routeName:
      // return DashBoard.route();
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: '/error'),
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text(
            'Error',
          ),
        ),
        body: const Center(
          child: Text(
            'Something went wrong',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
