import 'package:flutter/material.dart';
import 'package:yukti/screens/nav/bottom_nav_item_enum.dart';

class BottomNavBar extends StatelessWidget {
  final Map<BottomNavItem, IconData>? items;
  final BottomNavItem? selectedItem;
  final Function(int)? onTap;

  const BottomNavBar({
    Key? key,
    this.items,
    this.selectedItem,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: onTap,
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedItemColor: Theme.of(context).primaryColor,
      unselectedItemColor: Colors.grey,
      currentIndex: BottomNavItem.values.indexOf(selectedItem!),
      items: items!
          .map(
            (item, icon) => MapEntry(
              item.toString(),
              BottomNavigationBarItem(
                icon: Icon(icon, size: 30.0),
                label: '',
              ),
            ),
          )
          .values
          .toList(),
    );
  }
}
