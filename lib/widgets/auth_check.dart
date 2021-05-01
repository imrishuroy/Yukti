// import 'package:auth_with_provider/homescreen.dart';
// import 'package:auth_with_provider/services/firebase_auth_service.dart';
// import 'package:auth_with_provider/sigin_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:oriental_app/providers/firebase_methods_provider.dart';
// import 'package:provider/provider.dart';

// class AuthWidet extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final authService =
//         Provider.of<FirebaseMethodsProvider>(context, listen: false);
//     return StreamBuilder(
//       stream: authService.onAuthStateChanged,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.active) {
//           final user = snapshot.data;
//           return user != null ? HomeScreen() : SigInScreen();
//         }
//         return Scaffold(
//           body: Center(
//             child: CircularProgressIndicator(),
//           ),
//         );
//       },
//     );
//   }
// }
