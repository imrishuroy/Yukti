import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:yukti/enums/nav_item.dart';

class BottomNavBar extends StatelessWidget {
  final NavItem? navItem;
  final Function(NavItem)? onitemSelected;

  BottomNavBar({
    Key? key,
    @required this.navItem,
    @required this.onitemSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 20.0,
      type: BottomNavigationBarType.shifting,

      //   type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      iconSize: 20,
      selectedFontSize: 12,
      unselectedFontSize: 10,
      selectedItemColor: Colors.green,
      unselectedItemColor: Colors.grey,
      currentIndex: NavItem.values.indexOf(navItem!),
      onTap: (index) => onitemSelected!(NavItem.values[index]),
      items: NavItem.values.map((item) {
        return BottomNavigationBarItem(
            icon: _itemIcon(item), label: _label(item));
      }).toList(),
    );
  }
}

Widget _itemIcon(NavItem item) {
  if (item == NavItem.dashboard) {
    return Icon(Icons.dashboard);
  } else if (item == NavItem.gallery) {
    return Icon(FontAwesomeIcons.images);
  } else if (item == NavItem.happenings) {
    return Icon(FontAwesomeIcons.calendarAlt);
  } else if (item == NavItem.profile) {
    return Icon(Icons.person);
  }

  return Icon(Icons.person);
}

String _label(NavItem item) {
  if (item == NavItem.dashboard) {
    return 'Home';
  } else if (item == NavItem.gallery) {
    return 'Gallery';
  } else if (item == NavItem.happenings) {
    return 'Happenings';
  } else if (item == NavItem.profile) {
    return 'Profile';
  }

  return '';
}
