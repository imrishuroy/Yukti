import 'package:admin_yukti/blocs/auth/auth_bloc.dart';
import 'package:admin_yukti/config/auth_wrapper.dart';
import 'package:admin_yukti/config/custom_router.dart';
import 'package:admin_yukti/repositories/auth/auth_repo.dart';
import 'package:admin_yukti/repositories/firestore/firestore_repository.dart';
import 'package:admin_yukti/repositories/lecture/lecture_repositoy.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        RepositoryProvider<LectureRepository>(
          create: (_) => LectureRepository(),
        ),
        RepositoryProvider<FirestoreRepository>(
          create: (_) => FirestoreRepository(),
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
              create: (context) =>
                  AuthBloc(authRepository: context.read<AuthRepository>()))
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
