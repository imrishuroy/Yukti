import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yukti/config/auth_wrapper.dart';
import 'package:yukti/config/custom_router.dart';
import 'package:yukti/repositories/auth/auth_repository.dart';

import 'blocs/blocs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = SimpleBlocObserver();
  EquatableConfig.stringify = kDebugMode;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (_) => AuthRepository(),
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
              authRepository: context.read<AuthRepository>(),
            ),
          )
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Yukti',
          theme: ThemeData(
            primaryColor: Colors.green,
            primarySwatch: Colors.green,
            buttonColor: Colors.green,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          onGenerateRoute: CustomRouter.onGenerateRoute,
          initialRoute: AuthWrapper.routeName,
        ),
      ),
    );
  }
}
