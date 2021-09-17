import 'package:flutter/material.dart';
import 'package:yukti/respositories/auth/auth_repository.dart';
import 'package:yukti/widgets/user_profile_image.dart';

import 'user_profile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatefulWidget {
  static const String routeName = '/profile-screen';

  const ProfileScreen({Key? key}) : super(key: key);

  static Route route() {
    return PageRouteBuilder(
        settings: const RouteSettings(name: routeName),
        pageBuilder: (context, _, __) => const ProfileScreen());
  }

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String documentId() => DateTime.now().toIso8601String();

  void _logout() async {
    await context.read<AuthRepository>().signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  backgroundColor: Color.fromRGBO(29, 38, 40, 1),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: _logout, icon: const Icon(Icons.logout_rounded)),
          const SizedBox(width: 10.0),
        ],
        centerTitle: true,
        title: const Text(
          'Your Profile',
          style: TextStyle(color: Colors.black),
        ),
        // backgroundColor: Color(0XFF00286E),
        //   backgroundColor: Color.fromRGBO(40, 200, 253, 1),
        //  backgroundColor: Color.fromRGBO(0, 141, 82, 1),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(150.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // mainAxisSize: MainAxisSize.max,
            children: const [
              UserProfileImage(),
              SizedBox(height: 25.0),
            ],
          ),
        ),
      ),
      body: const UserProfile(),
    );
  }
}
