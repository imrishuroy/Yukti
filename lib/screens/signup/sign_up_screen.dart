import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yukti/repositories/auth/auth_repository.dart';
import 'package:yukti/reuseables/google_button.dart';

import 'package:yukti/screens/signup/cubit/signup_cubit.dart';
import 'package:yukti/widgets/error_dialog.dart';
import 'package:yukti/widgets/greeting_widget.dart';

class SignUpScreen extends StatelessWidget {
  static const String routeName = '/register-screen';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => BlocProvider<SignupCubit>(
        create: (_) => SignupCubit(
          authRepository: context.read<AuthRepository>(),
        ),
        child: SignUpScreen(),
      ),
    );
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _submitForm(BuildContext context, bool isSubmitting) {
    if (_formKey.currentState!.validate() && !isSubmitting) {
      context.read<SignupCubit>().signUpWithCredentials();
    }
  }

  void showSnackBar({BuildContext? context, String? title}) {
    ScaffoldMessenger.of(context!).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 3),
        content: Text(
          '$title',
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.redAccent,
      ),
    );
  }

  // void _registerUser(BuildContext ctx) async {
  //   final form = _formKey.currentState!;
  //   FocusScope.of(context).unfocus();

  //   if (form.validate()) {
  //     form.save();
  //     try {
  //       setState(() {
  //         _isLoading = true;
  //       });
  //       // await Provider.of<AuthServices>(context, listen: false)
  //       //     .createUserWithEmailAndPassword(
  //       //       email: _emailController.text,
  //       //       password: _passwordController.text,
  //       //     )
  //       //     .then((value) => Navigator.pushReplacementNamed(context, '/'));
  //     } on FirebaseAuthException catch (error) {
  //       setState(() {
  //         _isLoading = false;
  //       });
  //       print(error.code);

  //       if (error.code == 'email-already-in-use') {
  //         //   print('The account already exists for that email.');
  //         showSnackBar(context: context, title: 'Email already in use');
  //       }
  //       if (error.code == 'invalid-email') {
  //         showSnackBar(context: context, title: 'Invalid Email');
  //       }
  //     } on SocketException catch (error) {
  //       print(error);
  //       setState(() {
  //         _isLoading = false;
  //       });
  //       showSnackBar(
  //           context: context, title: 'Something went wrong, try again!');
  //     } catch (error) {
  //       setState(() {
  //         _isLoading = false;
  //       });
  //       print('Register Error : $error');
  //       showSnackBar(
  //           context: context, title: 'Something went wrong, Try Again,');
  //     }
  //   }
  // }

  // Future googleSignIn(BuildContext context) async {
  //   // final AuthServices auth = Provider.of(context, listen: false);
  //   try {
  //     setState(() {
  //       _isLoading = true;
  //     });
  //     // await auth
  //     //     .signInWithGoogle()
  //     //     .then((value) => Navigator.pushReplacementNamed(context, '/'));
  //   } on PlatformException catch (error) {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //     if (error.message!.contains('sign_in_failed')) {
  //       showSnackBar(context: context, title: 'Sign In Failed');
  //     }
  //     print(error);
  //     showSnackBar(context: context, title: error.message);
  //   }
  // }
  //
  //
  // _isLoading == true
  //     ? Padding(
  //         padding: const EdgeInsets.only(top: 25.0),
  //         child: Center(
  //           child: CircularProgressIndicator(),
  //         ),
  //       )
  //     :

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async => false,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: BlocConsumer<SignupCubit, SignupState>(
          listener: (context, state) {
            if (state.status == SignUpStatus.error) {
              showDialog(
                context: context,
                builder: (context) => ErrorDialog(
                  content: state.failure.message,
                ),
              );
            }
          },
          builder: (context, state) {
            return Scaffold(
              backgroundColor: Color.fromRGBO(29, 38, 40, 1),
              body: Form(
                key: _formKey,
                child: ListView(
                  children: <Widget>[
                    greetingWidget(height),
                    Container(
                      padding:
                          EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextFormField(
                            style:
                                TextStyle(color: Colors.white, fontSize: 16.0),
                            key: key,
                            // onSaved: (value) => email = value,
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (value) =>
                                context.read<SignupCubit>().emailChanged(value),

                            validator: (value) =>
                                !(value!.contains('@gmail.com'))
                                    ? 'Invalid Email'
                                    : null,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.green,
                                  width: 2.0,
                                ),
                              ),
                              prefixIcon: Icon(
                                Icons.mail,
                                color: Colors.green,
                              ),
                              labelText: 'EMAIL',
                              labelStyle: TextStyle(
                                color: Colors.green,
                                fontFamily: 'Montserrat',
                              ),
                              hintText: 'Enter Your Email',
                              hintStyle: TextStyle(color: Colors.white),
                              border: OutlineInputBorder(),
                            ),
                          ),

                          SizedBox(height: 25.0),
                          TextFormField(
                            style:
                                TextStyle(color: Colors.white, fontSize: 16.0),

                            //obscureText: _hidePassword,
                            onChanged: (value) => context
                                .read<SignupCubit>()
                                .passwordChanges(value),

                            validator: (value) =>
                                value!.length < 6 ? 'Password too short' : null,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.green,
                                  width: 2.0,
                                ),
                              ),
                              labelStyle: TextStyle(
                                  color: Colors.green,
                                  fontFamily: 'Montserrat'),
                              prefixIcon: Icon(Icons.lock, color: Colors.green),
                              // suffixIcon: IconButton(
                              //   color: Colors.green,
                              //   icon: Icon(
                              //     _hidePassword ? Icons.visibility : Icons.visibility_off,
                              //   ),
                              //   onPressed: () {
                              //     setState(() {
                              //       _hidePassword = !_hidePassword;
                              //     });
                              //   },
                              // ),
                              hintStyle: TextStyle(color: Colors.white),
                              labelText: 'PASSWORD',
                              hintText: 'Enter Your Password',
                              border: OutlineInputBorder(),
                            ),
                          ),

                          SizedBox(height: 35.0),
                          //
                          ElevatedButton(
                            onPressed: () => _submitForm(context,
                                state.status == SignUpStatus.submitting),
                            child: Padding(
                              padding: const EdgeInsets.all(11.5),
                              child: Text(
                                'Register',
                                style: TextStyle(
                                  fontSize: 16.5,
                                  letterSpacing: 1.0,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      'OR',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: GoogleSignInButton(
                        // onPressed: () => googleSignIn(context),
                        onPressed: () {},
                        title: 'Register with Google',
                      ),
                    ),
                    SizedBox(height: 25.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Have an Account?',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                          ),
                        ),
                        SizedBox(width: 5.0),
                        GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 16.0,
                              letterSpacing: 1.0,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
