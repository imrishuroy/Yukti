import 'package:flutter/material.dart';
import 'package:yukti/blocs/bloc/auth_bloc.dart';
import 'package:yukti/models/app_user.dart';
import 'package:yukti/respositories/user/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'add_profile_screen.dart';
import 'edit_profile_screen.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _userId = context.read<AuthBloc>().state.user?.uid;
    final _userRepo = context.read<UserRepository>();

    return FutureBuilder<AppUser?>(
      future: _userRepo.getUserById(userId: _userId),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Some thing went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.data == null) {
          return Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: const Color.fromRGBO(0, 141, 82, 1), // background
                // onPrimary: Colors.white, // foreground
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddProfileScreen(),
                  ),
                );
              },
              child: const Text(
                'Add Your Profile',
                style: TextStyle(fontSize: 17.0),
              ),
            ),
          );
        }

        final user = snapshot.data;

        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 27.0,
            vertical: 4.0,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20.0),
                Row(
                  children: [
                    _profileDomainCard(value: user?.branch),
                    _profileDomainCard(value: user?.sem),
                    _profileDomainCard(value: user?.section),
                  ],
                ),
                const SizedBox(height: 25.0),
                _profileLabelText(label: 'Name'),
                const SizedBox(height: 3.0),
                Text(
                  user?.name ?? 'N/A',
                  style: const TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 22.0),
                _profileLabelText(label: 'Enrollment No'),
                const SizedBox(height: 3.0),
                Text(
                  user?.enrollNo ?? 'N/A',
                  style: const TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 22.0),
                _profileLabelText(label: 'Father\'s Name'),
                const SizedBox(height: 3.0),
                Text(
                  user?.fatherName ?? 'N/A',
                  style: const TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 22.0),
                _profileLabelText(label: 'Mother\'s Name'),
                const SizedBox(height: 3.0),
                Text(
                  user?.motherName ?? 'N/A',
                  style: const TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 22.0),
                _profileLabelText(label: 'Mobile Number'),
                const SizedBox(height: 3.0),
                Text(
                  user?.mobileNo ?? 'N/A',
                  style: const TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30.0),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: const Color(0XFF00286E)),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EditProfileScreen(),
                      ),
                    ),
                    child: const Text('Edit Your Profile'),
                  ),
                )
              ],
            ),
          ),
        );

        // QuerySnapshot? querySnapshot = snapshot.data;
      },
    );
  }

  Widget _profileLabelText({String? label}) {
    return Column(
      children: [
        Text(
          '$label',
          style: const TextStyle(
            fontSize: 16.0,
            // color: Color.fromRGBO(255, 203, 0, 1),
            color: Color.fromRGBO(255, 203, 0, 1),
            letterSpacing: 1.1,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6.5),
      ],
    );
  }

  Widget _profileDomainCard({
    String? value,
  }) {
    return Expanded(
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Text(
              value ?? 'N/A',
              style: const TextStyle(
                //color: Color.fromRGBO(255, 203, 0, 1),
                color: Color.fromRGBO(0, 141, 82, 1),
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
