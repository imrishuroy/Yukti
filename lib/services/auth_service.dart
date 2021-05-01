// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/services.dart';
// import 'package:oriental_management/models/app_user.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// abstract class AuthServices {
//   Stream<AppUser?> get onAuthChanges;
//   Future<AppUser?> currentUser();
//   Future<AppUser?> createUserWithEmailAndPassword({
//     String? email,
//     String? password,
//   });
//   Future<AppUser?> signInWithEmailAndPassword({
//     String? email,
//     String? password,
//   });
//   Future<AppUser?> signInWithGoogle();
//   Future<void> signOutUser();
//   Future<void>? forgotPassword({String? email});
// }

// class Auth implements AuthServices {
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   AppUser? _appUser(User? user) {
//     if (user == null) {
//       return null;
//     } else {
//       return AppUser(
//         uid: user.uid,
//         name: user.displayName,
//         photUrl: user.photoURL,

//         // isVerified: user.emailVerified,
//       );
//     }
//   }

//   @override
//   Stream<AppUser?> get onAuthChanges {
//     return _auth.authStateChanges().map(_appUser);
//   }

//   @override
//   Future<AppUser?> currentUser() async {
//     final user = _auth.currentUser;
//     return _appUser(user);
//   }

//   @override
//   Future<AppUser?> createUserWithEmailAndPassword(
//       {String? email, String? password}) async {
//     final UserCredential authResult = await _auth
//         .createUserWithEmailAndPassword(email: email!, password: password!);
//     // User user = _auth.currentUser;
//     // if (!user.emailVerified) {
//     //   await user.sendEmailVerification();
//     //   user.reload();
//     // } else {
//     //   user.reload();
//     //   return _appUser(authResult.user);
//     // }
//     // user.reload();
//     // return _appUser(authResult.user);
//     await _auth.currentUser!.sendEmailVerification();
//     return _appUser(authResult.user);
//   }

//   @override
//   Future<AppUser?> signInWithEmailAndPassword(
//       {String? email, String? password}) async {
//     final UserCredential authResult = await _auth.signInWithEmailAndPassword(
//         email: email!, password: password!);
//     return _appUser(authResult.user);
//   }

//   sendEmailVerificationLink() async {
//     User user = _auth.currentUser!;
//     if (!user.emailVerified) {
//       await user.sendEmailVerification();
//     }
//   }

//   @override
//   Future<AppUser?> signInWithGoogle() async {
//     final googleSignIn = GoogleSignIn();
//     final googleUser = await googleSignIn.signIn();
//     if (googleUser != null) {
//       final googleAuth = await googleUser.authentication;
//       if (googleAuth.idToken != null) {
//         final userCredential =
//             await _auth.signInWithCredential(GoogleAuthProvider.credential(
//           idToken: googleAuth.idToken,
//           accessToken: googleAuth.accessToken,
//         ));
//         print(userCredential.user?.photoURL);
//         return _appUser(userCredential.user);
//       } else {
//         throw PlatformException(
//           code: 'ERROR_MISSING_GOOGLE_ID_TOKEN',
//           message: 'Missing Google ID Token',
//         );
//       }
//     } else {
//       throw PlatformException(
//         code: 'ERROR_ABORTED_BY_USER',
//         message: 'Sign In aborted',
//       );
//     }
//   }

//   @override
//   Future<void> signOutUser() async {
//     final googleSignIn = GoogleSignIn();
//     await googleSignIn.signOut();
//     await _auth.signOut();
//   }

//   @override
//   Future<void>? forgotPassword({String? email}) async {
//     try {
//       await _auth.sendPasswordResetEmail(email: email!);
//     } catch (error) {
//       throw FirebaseAuthException(
//         code: 'user-not-found',
//         message: 'User not found',
//       );
//     }
//   }
// }
