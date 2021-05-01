import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yukti/blocs/auth/auth_bloc.dart';
import 'package:yukti/screens/login/login_screen.dart';
import 'package:yukti/screens/nav/nav_screen.dart';

import 'package:yukti/screens/succuss_screen.dart';

class AuthWrapper extends StatelessWidget {
  static const String routeName = '/auth-wrapper';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) => AuthWrapper(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          print('State: $state');
          if (state.status == AuthStatus.unauthenticated) {
            Navigator.pushNamed(context, LoginScreen.routeName);
          } else if (state.status == AuthStatus.authenticated) {
            // Navigator.of(context)
            //     .push(MaterialPageRoute(builder: (_) => SuccessScreen()));
            Navigator.of(context).pushNamed(NavScreen.routeName);
          }
        },
        child: const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
