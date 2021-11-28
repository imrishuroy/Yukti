import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/blocs/tab/tab_bloc.dart';
import '/config/auth_wrapper.dart';
import '/config/custom_router.dart';
import '/constants/constants.dart';
import '/respositories/auth/auth_repository.dart';
import '/respositories/firebase/firebase_repositroy.dart';
import '/respositories/lectures/lectures_repository.dart';
import '/respositories/user/user_repository.dart';

import 'blocs/auth/auth_bloc.dart';
import 'blocs/profile/profile_bloc.dart';
import 'blocs/simple_bloc_consumer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  EquatableConfig.stringify = kDebugMode;
  Bloc.observer = SimpleBlocObserver();
  //BlocOverrides.runZoned(() {}, blocObserver: SimpleBlocObserver());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (_) => AuthRepository(),
        ),
        RepositoryProvider<UserRepository>(
          create: (_) => UserRepository(),
        ),
        RepositoryProvider<LecturesRepository>(
          create: (_) => LecturesRepository(),
        ),
        RepositoryProvider<FirebaseRepositroy>(
          create: (_) => FirebaseRepositroy(),
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider<TabBloc>(
            create: (context) => TabBloc(),
          ),
          BlocProvider<ProfileBloc>(
            create: (context) => ProfileBloc(
              userRepository: context.read<UserRepository>(),
              authBloc: context.read<AuthBloc>(),
              //)..add(RefreshProfileUser()),
            ),
          ),
        ],
        child: MaterialApp(
          //  title: 'Yukti',
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.black54,
            primaryColor: primaryColor,

            elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(primary: primaryColor)),
            // primaryColor: ,
            //   primarySwatch: Colors.green,
            // primaryColor: Color.fromRGBO(25, 23, 37, 1),
            //scaffoldBackgroundColor: Color.fromRGBO(25, 23, 37, 1),
            appBarTheme: const AppBarTheme(
              elevation: 0.0,
              titleTextStyle: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.2,
              ),
              color: Colors.black54,
              //backgroundColor: Color.fromRGBO(25, 23, 37, 1),
            ),
          ),
          debugShowCheckedModeBanner: false,
          onGenerateRoute: CustomRouter.onGenerateRoute,
          initialRoute: AuthWrapper.routeName,
        ),
      ),
    );
  }
}
