import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yukti/repositories/auth/auth_repository.dart';

class SuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Succussfull'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                RepositoryProvider.of<AuthRepository>(context).signOutUser();
              },
              child: Text('LogOut'),
            ),
          ],
        ),
      ),
    );
  }
}
