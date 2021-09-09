import 'package:admin_yukti/blocs/auth/auth_bloc.dart';
import 'package:admin_yukti/screens/home/home_screen.dart';
import 'package:admin_yukti/screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthWrapper extends StatelessWidget {
  static const String routeName = '/auth';

  const AuthWrapper({Key? key}) : super(key: key);

  static Route route() {
    return PageRouteBuilder(
      settings: const RouteSettings(name: routeName),
      pageBuilder: (context, _, __) => const AuthWrapper(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.unauthenticated) {
          Navigator.of(context).pushNamed(LoginScreen.routeName);
        } else if (state.status == AuthStatus.authenticated) {
          Navigator.of(context).pushNamed(HomeScreen.routeName);
          // Navigator.of(context).pushNamed(BatteryDashBoard.routeName);
        }
      },
      child: const Scaffold(body: Center(child: CircularProgressIndicator())),
    );
  }
}
