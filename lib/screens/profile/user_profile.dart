import 'package:flutter/material.dart';
import 'package:yukti/blocs/bloc/auth_bloc.dart';
import 'package:yukti/models/app_user.dart';
import 'package:yukti/respositories/user/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _userId = context.read<AuthBloc>().state.user?.uid;
    final _userRepo = context.read<UserRepository>();

    return FutureBuilder<AppUser?>(
      future: _userRepo.getUserById(userId: _userId),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasError) {
          return Text('Some thing went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.data == null) {
          return Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color.fromRGBO(0, 141, 82, 1), // background
                // onPrimary: Colors.white, // foreground
              ),
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => AddProfileScreen(database: database),
                //   ),
                // );
              },
              child: Text(
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
                SizedBox(height: 20.0),
                Row(
                  children: [
                    _profileDomainCard(value: user?.branch),
                    _profileDomainCard(value: user?.sem),
                    _profileDomainCard(value: user?.section),
                  ],
                ),
                SizedBox(height: 25.0),
                _profileLabelText(label: 'Name'),
                SizedBox(height: 3.0),
                Text(
                  '${user?.name ?? 'N/A'}',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 22.0),
                _profileLabelText(label: 'Enrollment No'),
                SizedBox(height: 3.0),
                Text(
                  '${user?.enrollNo ?? 'N/A'}',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 22.0),
                _profileLabelText(label: "Father's Name"),
                SizedBox(height: 3.0),
                Text(
                  '${user?.fatherName ?? 'N/A'}',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 22.0),
                _profileLabelText(label: 'Mother\'s Name'),
                SizedBox(height: 3.0),
                Text(
                  '${user?.motherName ?? 'N/A'}',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 22.0),
                _profileLabelText(label: 'Mobile Number'),
                SizedBox(height: 3.0),
                Text(
                  '${user?.mobileNo ?? 'N/A'}',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 30.0),
                Center(
                  child: ElevatedButton(
                    onPressed: () {},
                    // onPressed: () => Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => EditProfileScreen(
                    //       database: database,
                    //     ),
                    //   ),
                    // ),
                    child: Text('Edit Your Profile'),
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
          style: TextStyle(
            fontSize: 16.0,
            // color: Color.fromRGBO(255, 203, 0, 1),
            color: Color.fromRGBO(255, 203, 0, 1),
            letterSpacing: 1.1,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 6.5),
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
              '${value ?? 'N/A'}',
              style: TextStyle(
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
