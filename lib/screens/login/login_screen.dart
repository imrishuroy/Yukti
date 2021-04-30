import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:yukti/reuseables/google_button.dart';
import 'package:yukti/reuseables/reuseable_email_field.dart';
import 'package:yukti/reuseables/reuseable_password_field.dart';
import 'package:yukti/screens/forget_password.dart/forget_pasword_screen.dart';
import 'package:yukti/screens/signup/sign_up_screen.dart';
import 'package:yukti/widgets/greeting_widget.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => new _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;

  void showSnackBar({BuildContext? context, String? title}) {
    ScaffoldMessenger.of(context!).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 3),
        content: Text(
          '$title',
          style: TextStyle(fontSize: 16.0),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _login(BuildContext context) async {
    final form = _formKey.currentState!;
    FocusScope.of(context).unfocus();
    if (form.validate()) {
      form.save();
      try {
        setState(() {
          _isLoading = true;
        });
        // UserCredential userCredential =
        // await Provider.of<AuthServices>(context, listen: false)
        //     .signInWithEmailAndPassword(
        //   email: _emailController.text,
        //   password: _passwordController.text,
        // );
      } on FirebaseAuthException catch (error) {
        setState(() {
          _isLoading = false;
        });
        if (error.code == 'user-not-found') {
          print('No user found for that email.');
          showSnackBar(context: context, title: 'User not found');
        }
        if (error.code == 'wrong-password') {
          showSnackBar(context: context, title: 'Wrong password');
        }
      } catch (error) {
        setState(() {
          _isLoading = false;
        });
        print(error);
      }
    }
  }

  Future googleSignIn(BuildContext context) async {
    // final AuthServices auth = Provider.of(context, listen: false);
    try {
      setState(() {
        _isLoading = true;
      });
      // await auth.signInWithGoogle();
    } on PlatformException catch (error) {
      setState(() {
        _isLoading = false;
      });
      print(error);
      if (error.message!.contains('sign_in_failed')) {
        showSnackBar(context: context, title: 'Sign In Failed');
      }
      showSnackBar(context: context, title: error.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        // statusBarColor: Colors.white54,
        statusBarColor: Color.fromRGBO(0, 141, 82, 1),
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return Scaffold(
      backgroundColor: Color.fromRGBO(29, 38, 40, 1),
      body: _isLoading == true
          ? Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Form(
              key: _formKey,
              child: ListView(
                children: <Widget>[
                  // greetingWidget(),
                  greetingWidget(height),

                  SizedBox(height: height < 750 ? 15.0 : 25.0),
                  Container(
                    padding:
                        EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        ReuseableEmailField(
                          textController: _emailController,
                          key: ValueKey('loginEmail'),
                        ),
                        SizedBox(height: 25.0),
                        ReuseablePasswordField(
                          key: ValueKey('loginPassword'),
                          textController: _passwordController,
                        ),
                        SizedBox(height: 5.0),
                        Container(
                          alignment: Alignment(1.0, 0.0),
                          padding: EdgeInsets.only(top: 15.0, left: 20.0),
                          child: InkWell(
                            onTap: () => Navigator.pushNamed(
                              context,
                              ForgotPaswordScreen.routeName,
                            ),
                            child: Text(
                              'Forgot Password',
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat',
                                letterSpacing: 0.9,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 40.0),
                        ElevatedButton(
                          onPressed: () => _login(context),
                          child: Padding(
                            padding: const EdgeInsets.all(11.5),
                            child: Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 17.0,
                                letterSpacing: 1.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat',
                              ),
                            ),
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
                        GoogleSignInButton(
                          onPressed: () => googleSignIn(context),
                          title: 'Log In with Google',
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 22.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Need an account?',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Colors.white,
                          fontSize: 15.0,
                        ),
                      ),
                      SizedBox(width: 5.0),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, SignUpScreen.routeName);
                        },
                        child: Text(
                          'Register',
                          style: TextStyle(
                            color: Colors.green,
                            fontFamily: 'Montserrat',
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
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
  }
}
