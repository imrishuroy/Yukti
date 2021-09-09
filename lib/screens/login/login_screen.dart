import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import 'package:yukti/respositories/auth/auth_repository.dart';

import 'package:yukti/screens/login/cubit/login_cubit.dart';
import 'package:yukti/screens/signup/signup_screen.dart';

import 'package:yukti/widgets/error_dialog.dart';
import 'package:yukti/widgets/google_button.dart';
import 'package:yukti/widgets/greetings_widget.dart';

import 'forget_password.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = '/login';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => BlocProvider<LoginCubit>(
        create: (_) =>
            LoginCubit(authRepository: context.read<AuthRepository>()),
        child: LoginScreen(),
      ),
    );
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _submitForm(BuildContext context, bool isSubmitting) {
    if (_formKey.currentState!.validate() && !isSubmitting) {
      context.read<LoginCubit>().signInWithEmail();
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Color.fromRGBO(25, 23, 37, 1),
        // statusBarColor: Color(0XFF00286E),
        //  statusBarColor: Color.fromRGBO(0, 141, 82, 1),
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return WillPopScope(
      onWillPop: () async => false,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state.status == LoginStatus.error) {
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
              body: state.status == LoginStatus.submitting
                  ? Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : Form(
                      key: _formKey,
                      child: ListView(
                        children: <Widget>[
                          GreetingsWidget(height: height),

                          ///  SizedBox(height: height < 750 ? 7.0 : 7.0),
                          Container(
                            padding: EdgeInsets.only(
                                top: 15.0, left: 20.0, right: 20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                TextFormField(
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16.0),
                                  keyboardType: TextInputType.emailAddress,
                                  onChanged: (value) => context
                                      .read<LoginCubit>()
                                      .emailChanged(value),
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
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16.0),
                                  obscureText: !state.showPassword,
                                  onChanged: (value) => context
                                      .read<LoginCubit>()
                                      .passwordChanged(value),
                                  validator: (value) => value!.length < 6
                                      ? 'Password too short'
                                      : null,
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
                                    prefixIcon:
                                        Icon(Icons.lock, color: Colors.green),
                                    suffixIcon: IconButton(
                                      color: Colors.green,
                                      icon: Icon(
                                        state.showPassword
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                      ),
                                      onPressed: () {
                                        context
                                            .read<LoginCubit>()
                                            .showPassword(state.showPassword);
                                      },
                                    ),
                                    hintStyle: TextStyle(color: Colors.white),
                                    labelText: 'PASSWORD',
                                    hintText: 'Enter Your Password',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                SizedBox(height: 5.0),
                                Container(
                                  alignment: Alignment(1.0, 0.0),
                                  padding:
                                      EdgeInsets.only(top: 15.0, left: 20.0),
                                  child: InkWell(
                                    onTap: () => Navigator.pushNamed(
                                        context, ForgotPaswordScreen.routeName),
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
                                  onPressed: () => _submitForm(context,
                                      state.status == LoginStatus.submitting),
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
                                //if (UniversalPlatform.isIOS)
                                SizedBox(
                                  width: 250.0,
                                  child: SignInWithAppleButton(
                                    onPressed: () {
                                      context.read<LoginCubit>().appleLogin();
                                    },
                                    style: SignInWithAppleButtonStyle.black,
                                  ),
                                ),
                                SizedBox(height: 20.0),
                                GoogleSignInButton(
                                  onPressed: () =>
                                      context.read<LoginCubit>().googleSignIn(),
                                  title: 'Log In with Google',
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 25.0),
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
                                  Navigator.pushNamed(
                                      context, SignupScreen.routeName);
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
          },
        ),
      ),
    );
  }
}
