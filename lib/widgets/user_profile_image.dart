import 'package:flutter/material.dart';
import 'package:yukti/blocs/bloc/auth_bloc.dart';
import 'package:yukti/models/app_user.dart';
import 'package:yukti/respositories/user/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserProfileImage extends StatelessWidget {
  const UserProfileImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _userRepo = context.read<UserRepository>();
    final _userId = context.read<AuthBloc>().state.user?.uid;
    return FutureBuilder<AppUser?>(
      future: _userRepo.getUserById(userId: _userId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final user = snapshot.data;
        print(user?.photUrl);

        if (user != null) {
          if (user.photUrl != null) {
            if (user.photUrl!.isNotEmpty) {
              return CircleAvatar(
                radius: 60.0,
                backgroundColor: Colors.white70,
                child: CircleAvatar(
                  radius: 55.0,
                  backgroundColor: Colors.white,
                  backgroundImage: NetworkImage(user.photUrl!),
                ),
              );
            }
          }
        }
        return const CircleAvatar(
          radius: 60.0,
          backgroundColor: Colors.white,
          child: CircleAvatar(
            radius: 55.0,
            backgroundColor: Colors.white70,
            child: Icon(
              Icons.image,
              color: Colors.green,
            ),
          ),
        );
      },
    );

    // StreamBuilder<QuerySnapshot>(
    //   stream: database?.profileDataSnapshot,
    //   builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    //     if (snapshot.hasError) {
    //       return Center(child: Text('Something went wrong'));
    //     }
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return Center(child: CircularProgressIndicator());
    //     }
    //     if (snapshot.data?.size == 0) {
    //       return CircleAvatar(
    //         radius: 60.0,
    //         backgroundColor: Colors.white,
    //         child: CircleAvatar(
    //           radius: 55.0,
    //           backgroundColor: Colors.white70,
    //           child: Icon(
    //             Icons.image,
    //             color: Colors.green,
    //           ),
    //         ),
    //       );
    //     }
    //     String? imageUrl = '${snapshot.data?.docs[0]['image_url']}';
    //     return CircleAvatar(
    //       radius: 60.0,
    //       backgroundColor: Colors.white70,
    //       child: CircleAvatar(
    //         radius: 55.0,
    //         backgroundColor: Colors.white,
    //         backgroundImage: NetworkImage(imageUrl),
    //       ),
    //     );
    //   },
    // );
  }
}
