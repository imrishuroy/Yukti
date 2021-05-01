import 'package:flutter/material.dart';

class DashBoard extends StatelessWidget {
  static const String routeName = '/dashboard';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => DashBoard(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('DashBoard'),
      ),
    );
  }
}
