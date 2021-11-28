import 'package:flutter/material.dart';
import 'package:yukti/widgets/loading_indicator.dart';
import '/blocs/auth/auth_bloc.dart';

import '/models/app_user.dart';
import '/models/assignment.dart';
import '/respositories/firebase/firebase_repositroy.dart';
import '/respositories/user/user_repository.dart';
import '/widgets/nothing_here.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'assignment_tile.dart';

class AssignmentsScreen extends StatefulWidget {
  static const String routeName = '/assignments';

  const AssignmentsScreen({Key? key}) : super(key: key);

  static Route route() {
    return PageRouteBuilder(
      settings: const RouteSettings(name: routeName),
      pageBuilder: (context, _, __) {
        return const AssignmentsScreen();
      },
    );
  }

  @override
  _AssignmentsScreenState createState() => _AssignmentsScreenState();
}

class _AssignmentsScreenState extends State<AssignmentsScreen> {
  @override
  void initState() {
    getCurrentUser();

    super.initState();
  }

  getCurrentUser() async {
    try {
      final authBloc = context.read<AuthBloc>();
      final userRepo = context.read<UserRepository>();

      _user = await userRepo.getUserById(userId: authBloc.state.user?.uid);
      setState(() {});
    } catch (error) {
      print('Errror getting current user ${error.toString()})');
    }
  }

  AppUser? _user;
  @override
  Widget build(BuildContext context) {
    //  final _user = context.read<AuthBloc>();
    final _firebaseRepo = context.read<FirebaseRepositroy>();

    return _user == null
        ? const Scaffold(body: Center(child: CircularProgressIndicator()))
        : FutureBuilder<List<Assignment?>>(
            future: _firebaseRepo.getUserAssignments(
                branch: _user?.branch,
                sem: _user?.sem,
                section: _user?.section),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const NothingHere(appBarTitle: 'Assignments');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(body: LoadingIndicator());
              }

              final assignments = snapshot.data;

              return Scaffold(
                appBar: AppBar(
                  actions: [
                    CircleAvatar(
                      radius: 14.0,
                      backgroundColor: Colors.white,
                      child: Text(
                        '${assignments?.length}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20.0),
                  ],
                  centerTitle: true,
                  // backgroundColor: const Color.fromRGBO(0, 141, 82, 1),
                  title: const Text('Assignments'),
                ),
                body: Column(
                  children: [
                    const SizedBox(height: 5.5),
                    Expanded(
                      child: ListView.builder(
                        itemCount: assignments?.length,
                        itemBuilder: (context, index) {
                          return AssignmentTile(
                            assignment: assignments?[index],
                          );
                        },
                      ),
                    )
                  ],
                ),
              );
            },
          );
  }
}
