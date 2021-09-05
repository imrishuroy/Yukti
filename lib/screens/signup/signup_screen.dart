// import 'dart:io';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:oriental_management/reuseables/google_button.dart';
// import 'package:oriental_management/reuseables/reuseable_email_field.dart';
// import 'package:oriental_management/reuseables/reuseable_password_field.dart';
// import 'package:oriental_management/services/auth_service.dart';

// import 'package:oriental_management/widgets/greeting_widget.dart';
// import 'package:provider/provider.dart';

// class RegisterScreen extends StatefulWidget {
//   static String routeName = '/register-screen';
//   @override
//   _RegisterScreenState createState() => _RegisterScreenState();
// }

// class _RegisterScreenState extends State<RegisterScreen> {
//   final _formKey = GlobalKey<FormState>();

//   TextEditingController _emailController = TextEditingController();
//   TextEditingController _passwordController = TextEditingController();

//   bool _isLoading = false;

//   void showSnackBar({BuildContext? context, String? title}) {
//     ScaffoldMessenger.of(context!).showSnackBar(
//       SnackBar(
//         duration: Duration(seconds: 3),
//         content: Text(
//           '$title',
//           textAlign: TextAlign.center,
//         ),
//         backgroundColor: Colors.redAccent,
//       ),
//     );
//   }

//   void _registerUser(BuildContext ctx) async {
//     final form = _formKey.currentState!;
//     FocusScope.of(context).unfocus();

//     if (form.validate()) {
//       form.save();
//       try {
//         setState(() {
//           _isLoading = true;
//         });
//         await Provider.of<AuthServices>(context, listen: false)
//             .createUserWithEmailAndPassword(
//               email: _emailController.text,
//               password: _passwordController.text,
//             )
//             .then((value) => Navigator.pushReplacementNamed(context, '/'));
//       } on FirebaseAuthException catch (error) {
//         setState(() {
//           _isLoading = false;
//         });
//         print(error.code);

//         if (error.code == 'email-already-in-use') {
//           //   print('The account already exists for that email.');
//           showSnackBar(context: context, title: 'Email already in use');
//         }
//         if (error.code == 'invalid-email') {
//           showSnackBar(context: context, title: 'Invalid Email');
//         }
//       } on SocketException catch (error) {
//         print(error);
//         setState(() {
//           _isLoading = false;
//         });
//         showSnackBar(
//             context: context, title: 'Something went wrong, try again!');
//       } catch (error) {
//         setState(() {
//           _isLoading = false;
//         });
//         print('Register Error : $error');
//         showSnackBar(
//             context: context, title: 'Something went wrong, Try Again,');
//       }
//     }
//   }

//   Future googleSignIn(BuildContext context) async {
//     final AuthServices auth = Provider.of(context, listen: false);
//     try {
//       setState(() {
//         _isLoading = true;
//       });
//       await auth
//           .signInWithGoogle()
//           .then((value) => Navigator.pushReplacementNamed(context, '/'));
//     } on PlatformException catch (error) {
//       setState(() {
//         _isLoading = false;
//       });
//       if (error.message!.contains('sign_in_failed')) {
//         showSnackBar(context: context, title: 'Sign In Failed');
//       }
//       print(error);
//       showSnackBar(context: context, title: error.message);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;
//     return Scaffold(
//       backgroundColor: Color.fromRGBO(29, 38, 40, 1),
//       body: _isLoading == true
//           ? Padding(
//               padding: const EdgeInsets.only(top: 25.0),
//               child: Center(
//                 child: CircularProgressIndicator(),
//               ),
//             )
//           : Form(
//               key: _formKey,
//               child: ListView(
//                 children: <Widget>[
//                   greetingWidget(height),
//                   Container(
//                     padding:
//                         EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: [
//                         ReuseableEmailField(
//                           textController: _emailController,
//                         ),
//                         SizedBox(height: 25.0),
//                         ReuseablePasswordField(
//                           textController: _passwordController,
//                         ),
//                         SizedBox(height: 35.0),
//                         ElevatedButton(
//                           onPressed: () => _registerUser(context),
//                           child: Padding(
//                             padding: const EdgeInsets.all(11.5),
//                             child: Text(
//                               'Register',
//                               style: TextStyle(
//                                 fontSize: 16.5,
//                                 letterSpacing: 1.0,
//                                 fontWeight: FontWeight.bold,
//                                 fontFamily: 'Montserrat',
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 20.0),
//                   Text(
//                     'OR',
//                     style: TextStyle(
//                       color: Colors.white,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                   SizedBox(height: 20.0),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                     child: GoogleSignInButton(
//                       onPressed: () => googleSignIn(context),
//                       title: 'Register with Google',
//                     ),
//                   ),
//                   SizedBox(height: 25.0),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         'Have an Account?',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 15.0,
//                         ),
//                       ),
//                       SizedBox(width: 5.0),
//                       GestureDetector(
//                         onTap: () => Navigator.of(context).pop(),
//                         child: Text(
//                           'Login',
//                           style: TextStyle(
//                             color: Colors.green,
//                             fontSize: 16.0,
//                             letterSpacing: 1.0,
//                             fontWeight: FontWeight.w600,
//                             decoration: TextDecoration.underline,
//                           ),
//                         ),
//                       )
//                     ],
//                   )
//                 ],
//               ),
//             ),
//     );
//   }
// }
