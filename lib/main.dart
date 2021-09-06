import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yukti/blocs/bloc/auth_bloc.dart';
import 'package:yukti/blocs/tab/tab_bloc.dart';
import 'package:yukti/config/auth_wrapper.dart';
import 'package:yukti/config/custom_router.dart';
import 'package:yukti/respositories/auth/auth_repository.dart';
import 'package:yukti/respositories/firebase/firebase_repositroy.dart';
import 'package:yukti/respositories/lectures/lectures_repository.dart';
import 'package:yukti/respositories/user/user_repository.dart';
import 'blocs/simple_bloc_consumer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  EquatableConfig.stringify = kDebugMode;
  Bloc.observer = SimpleBlocObserver();
  runApp(MyApp());
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
          )
        ],
        child: MaterialApp(
          theme: ThemeData(primarySwatch: Colors.green),
          debugShowCheckedModeBanner: false,
          onGenerateRoute: CustomRouter.onGenerateRoute,
          initialRoute: AuthWrapper.routeName,
        ),
      ),
    );
  }
}
