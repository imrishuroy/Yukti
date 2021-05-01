import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yukti/screens/nav/bottom_nav_bar.dart';
import 'package:yukti/screens/nav/cubit/bottom_nav_bar_cubit.dart';
import 'package:yukti/screens/nav/tab_navigator.dart';

import 'bottom_nav_item_enum.dart';

class NavScreen extends StatelessWidget {
  static const String routeName = '/nav';

  static Route route() {
    return PageRouteBuilder(
      settings: const RouteSettings(name: routeName),
      transitionDuration: const Duration(seconds: 0),
      pageBuilder: (_, __, ___) => BlocProvider<BottomNavBarCubit>(
        create: (_) => BottomNavBarCubit(),
        child: NavScreen(),
      ),
    );
  }

  final Map<BottomNavItem?, GlobalKey<NavigatorState>>? navigatorKeys = {
    BottomNavItem.dashbaord: GlobalKey<NavigatorState>(),
    BottomNavItem.gallery: GlobalKey<NavigatorState>(),
    BottomNavItem.profile: GlobalKey<NavigatorState>(),
  };

  final Map<BottomNavItem, IconData> items = const {
    BottomNavItem.dashbaord: Icons.home,
    BottomNavItem.gallery: Icons.photo_album,
    BottomNavItem.profile: Icons.account_circle_rounded
  };

  void _selectedBottomNavItem(
      BuildContext context, BottomNavItem? selectedItem, bool? isSameItem) {
    if (isSameItem!) {
      navigatorKeys![selectedItem]
          ?.currentState!
          .popUntil((route) => route.isFirst);
    }
    context.read<BottomNavBarCubit>().updateSelectedItem(selectedItem!);
  }

  Widget _buildOffStageNavigator(BottomNavItem currentItem, bool isSelected) {
    return Offstage(
      offstage: !isSelected,
      child: TabNavigator(
        navigatorKey: navigatorKeys![currentItem]!,
        items: currentItem,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: BlocBuilder<BottomNavBarCubit, BottomNavBarState>(
        builder: (context, state) {
          return Scaffold(
            // appBar: AppBar(
            //   //   elevation: 0.0,
            //   title: Text('Nav Screen'),
            //  ),
            body: Stack(
              children: items
                  .map(
                    (item, _) => MapEntry(
                      item,
                      _buildOffStageNavigator(item, item == state.selectedItem),
                    ),
                  )
                  .values
                  .toList(),
            ),
            bottomNavigationBar: BottomNavBar(
              items: items,
              selectedItem: state.selectedItem,
              onTap: (index) {
                final selectedItem = BottomNavItem.values[index];

                print(index);

                _selectedBottomNavItem(
                    context, selectedItem, selectedItem == state.selectedItem);
              },
            ),
          );
        },
      ),
    );
  }
}
