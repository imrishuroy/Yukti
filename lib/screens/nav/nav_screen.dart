import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yukti/enums/nav_item.dart';
import 'package:yukti/screens/nav/bloc/nav_bloc.dart';
import 'package:yukti/screens/nav/widgets/bottom_nav_bar.dart';
import 'package:yukti/screens/nav/widgets/switch_screen.dart';

class NavScreen extends StatelessWidget {
  static const String routeName = '/nav';

  static Route route() {
    return PageRouteBuilder(
      settings: const RouteSettings(name: routeName),
      pageBuilder: (context, _, __) => BlocProvider(
        create: (context) => NavBloc(),
        child: const NavScreen(),
      ),
    );
  }

  const NavScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: BlocBuilder<NavBloc, NavItem>(
        builder: (context, activeNavItem) {
          return Scaffold(
            backgroundColor: Colors.black45,
            //  backgroundColor: Color.fromRGBO(25, 23, 37, 1),
            body: SwitchScreen(navItem: activeNavItem),
            bottomNavigationBar: BottomNavBar(
              navItem: activeNavItem,
              onitemSelected: (item) => BlocProvider.of<NavBloc>(context)
                  .add(UpdateNavItem(item: item)),
            ),
          );
        },
      ),
    );
  }
}
