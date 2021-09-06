import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yukti/enums/app_tab.dart';

class TabSelector extends StatelessWidget {
  final AppTab? activeTab;
  final Function(AppTab)? onTabSelected;

  TabSelector({
    Key? key,
    @required this.activeTab,
    @required this.onTabSelected,
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
      currentIndex: AppTab.values.indexOf(activeTab!),
      onTap: (index) => onTabSelected!(AppTab.values[index]),
      items: AppTab.values.map((tab) {
        return BottomNavigationBarItem(icon: _tabIcon(tab), label: _label(tab));
      }).toList(),
    );
  }
}

Widget _tabIcon(AppTab tab) {
  if (tab == AppTab.home) {
    return Icon(Icons.dashboard);
  } else if (tab == AppTab.galley) {
    return Icon(FontAwesomeIcons.images);
  } else if (tab == AppTab.happenings) {
    return Icon(FontAwesomeIcons.calendarAlt);
  } else if (tab == AppTab.profile) {
    return Icon(Icons.person);
  }

  return Icon(Icons.person);
}

String _label(AppTab tab) {
  if (tab == AppTab.home) {
    return 'Home';
  } else if (tab == AppTab.galley) {
    return 'Gallery';
  } else if (tab == AppTab.happenings) {
    return 'Happenings';
  } else if (tab == AppTab.profile) {
    return 'Profile';
  }

  return '';
}
