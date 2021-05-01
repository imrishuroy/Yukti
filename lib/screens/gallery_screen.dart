import 'package:flutter/material.dart';

class GalleryScreen extends StatelessWidget {
  static const String routeName = '/gallery';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => GalleryScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Gallery Screen'),
      ),
    );
  }
}
