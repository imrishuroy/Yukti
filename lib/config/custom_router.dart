import 'package:admin_yukti/screens/assignments/assignment_selection.dart';
import 'package:admin_yukti/screens/attendance/attendance_selection.dart';
import 'package:admin_yukti/screens/lectures/lectures_selection.dart';

import '/screens/home/home_screen.dart';
import '/screens/login/login_screen.dart';
import 'package:flutter/material.dart';

import 'auth_wrapper.dart';

class CustomRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    print('Route: ${settings.name}');
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          settings: const RouteSettings(name: '/'),
          builder: (_) => const Scaffold(),
        );

      case AuthWrapper.routeName:
        return AuthWrapper.route();

      case LoginScreen.routeName:
        return LoginScreen.route();

      case HomeScreen.routeName:
        return HomeScreen.route();

      case LectureSelection.routeName:
        return LectureSelection.route();

      case AttendanceSelection.routeName:
        return AttendanceSelection.route();

      case AssignmentSelection.routeName:
        return AssignmentSelection.route();

      default:
        return ErrorRoute.route();
    }
  }
}

class ErrorRoute extends StatelessWidget {
  const ErrorRoute({Key? key}) : super(key: key);

  static const String routeNmae = '/error';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeNmae),
      builder: (_) => const ErrorRoute(),
    );
  }

  @override
  Widget build(BuildContext context) {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(AuthWrapper.routeName, (route) => false);
    return Center(
      child: Column(
        children: [
          const Text(
            'Something went wrong',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 6.0),
          TextButton(
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    AuthWrapper.routeName, (route) => false);
              },
              child: const Text('Re Try'))
        ],
      ),
    );
  }
}
