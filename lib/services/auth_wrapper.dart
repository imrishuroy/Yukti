// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:oriental_management/models/app_user.dart';
// import 'package:oriental_management/screens/homepage_screen.dart';
// import 'package:oriental_management/screens/login_screen.dart';

// import 'package:oriental_management/services/auth_service.dart';
// import 'package:oriental_management/services/database_service.dart';

// import 'package:provider/provider.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class AuthWrapper extends StatelessWidget {
//   final firebaseAuth = FirebaseAuth.instance;
//   final usersRef = FirebaseFirestore.instance.collection('users');

//   Future<bool> checkAvailabledata(String uid) async {
//     DocumentSnapshot doc = await usersRef.doc(uid).get();
//     if (!doc.exists) {
//       return true;
//     } else {
//       return false;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     // User? user = FirebaseAuth.instance.currentUser;
//     // final authF = FirebaseAuth.instance;
//     // authF.sendPasswordResetEmail(email: email)

//     final auth = Provider.of<AuthServices>(context);
//     return StreamBuilder<AppUser?>(
//       stream: auth.onAuthChanges,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.active) {
//           AppUser? user = snapshot.data;
//           if (user == null) {
//             return LoginScreen();
//           } else {
//             return Provider<DataBase>(
//               create: (context) => FireStoreDataBase(uid: user.uid),
//               child: HomeScreen(
//                 uid: user.uid,
//               ),
//             );
//           }
//         } else {
//           return Scaffold(
//             body: Center(
//               child: CircularProgressIndicator(),
//             ),
//           );
//         }
//       },
//     );
//   }
// }
