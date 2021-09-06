import 'package:flutter/material.dart';
import 'package:yukti/respositories/auth/auth_repository.dart';
import 'package:yukti/widgets/user_profile_image.dart';

import 'user_profile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatefulWidget {
  static String routeName = '/profile-screen';

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
      backgroundColor: Color.fromRGBO(29, 38, 40, 1),
      appBar: AppBar(
        actions: [
          IconButton(onPressed: _logout, icon: Icon(Icons.logout_rounded)),
          SizedBox(width: 10.0),
        ],
        centerTitle: true,
        title: Text('Your Profile'),
        backgroundColor: Color.fromRGBO(0, 141, 82, 1),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(150.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // mainAxisSize: MainAxisSize.max,
            children: [
              UserProfileImage(),
              SizedBox(height: 25.0),
            ],
          ),
        ),
      ),
      body: UserProfile(),
    );
  }
}
