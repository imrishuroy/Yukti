import 'package:flutter/material.dart';
import 'package:yukti/config/auth_wrapper.dart';
import 'package:yukti/screens/dashboard_screen.dart';
import 'package:yukti/screens/gallery_screen.dart';
import 'package:yukti/screens/login/login_screen.dart';
import 'package:yukti/screens/nav/nav_screen.dart';
import 'package:yukti/screens/profile_screen.dart';
import 'package:yukti/screens/signup/sign_up_screen.dart';

class CustomRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    print('Route: ${settings.name}');
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            settings: const RouteSettings(name: '/'),
            builder: (_) => Scaffold());

      case NavScreen.routeName:
        return NavScreen.route();

      case AuthWrapper.routeName:
        return AuthWrapper.route();

      case LoginScreen.routeName:
        return LoginScreen.route();

      case SignUpScreen.routeName:
        return SignUpScreen.route();
      default:
        return _errorRoute();
    }
  }

  static Route onGenerateNestedRouter(RouteSettings settings) {
    print('NestedRoute: ${settings.name}');
    switch (settings.name) {
      case ProfileScreen.routeName:
        return ProfileScreen.route();
      // args: settings.arguments as ProfileScreenArgs);
      case GalleryScreen.routeName:
        return GalleryScreen.route();
      case DashBoard.routeName:
        return DashBoard.route();
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
