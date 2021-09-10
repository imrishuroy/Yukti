import 'package:flutter/material.dart';
import 'package:yukti/screens/forms/forms_screen.dart';

import '/enums/nav_item.dart';
import '/screens/dashboard/dash_board.dart';
import '/screens/gallery/gallery_screen.dart';
import '/screens/happenings/happenings_screen.dart';

class SwitchScreen extends StatelessWidget {
  final NavItem navItem;

  const SwitchScreen({Key? key, required this.navItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (navItem) {
      case NavItem.dashboard:
        // return Center(child: Text('DashBoard'));
        return DashBoard();

      case NavItem.gallery:
        return GalleryScreen();

      case NavItem.happenings:
        return HappeningsScreen();

      case NavItem.forms:
        // return ProfileScreen();
        return FormScreen();

      default:
        return Center(
          child: Text('Wrong'),
        );
    }
  }
}
