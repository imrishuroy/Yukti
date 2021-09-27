import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '/respositories/auth/auth_repository.dart';

import '/screens/login/cubit/login_cubit.dart';
import '/screens/signup/signup_screen.dart';

import '/widgets/error_dialog.dart';
import '/widgets/google_button.dart';
import '/widgets/greetings_widget.dart';

import 'forget_password.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = '/login';

  LoginScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
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
      const SystemUiOverlayStyle(
        statusBarColor: Colors.black54,
        //statusBarColor: Color.fromRGBO(25, 23, 37, 1),
        // statusBarColor: Color(0XFF00286E),
        //  statusBarColor: Color.fromRGBO(0, 141, 82, 1),
        statusBarIconBrightness: Brightness.light,
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
              backgroundColor: Colors.black54,
              //   backgroundColor: Color.fromRGBO(29, 38, 40, 1),
              body: state.status == LoginStatus.submitting
                  ? const Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : Form(
                      key: _formKey,
                      child: ListView(
                        children: <Widget>[
                          GreetingsWidget(height: height),
                          SizedBox(height: height < 750 ? 15.0 : 12.0),
                          Container(
                            padding: const EdgeInsets.only(
                                top: 22.0, left: 20.0, right: 20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                TextFormField(
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 16.0),
                                  keyboardType: TextInputType.emailAddress,
                                  onChanged: (value) => context
                                      .read<LoginCubit>()
                                      .emailChanged(value),
                                  validator: (value) =>
                                      !(value!.contains('@gmail.com'))
                                          ? 'Invalid Email'
                                          : null,
                                  decoration: const InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                        width: 2.0,
                                      ),
                                    ),
                                    prefixIcon: Icon(
                                      Icons.mail,
                                      color: Colors.white,
                                    ),
                                    labelText: 'EMAIL',
                                    labelStyle: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Montserrat',
                                    ),
                                    hintText: 'Enter Your Email',
                                    hintStyle: TextStyle(color: Colors.white),
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                const SizedBox(height: 25.0),
                                TextFormField(
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 16.0),
                                  obscureText: !state.showPassword,
                                  onChanged: (value) => context
                                      .read<LoginCubit>()
                                      .passwordChanged(value),
                                  validator: (value) => value!.length < 6
                                      ? 'Password too short'
                                      : null,
                                  decoration: InputDecoration(
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                        width: 2.0,
                                      ),
                                    ),
                                    labelStyle: const TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Montserrat'),
                                    prefixIcon: const Icon(Icons.lock,
                                        color: Colors.white),
                                    suffixIcon: IconButton(
                                      color: Colors.white,
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
                                    hintStyle:
                                        const TextStyle(color: Colors.white),
                                    labelText: 'PASSWORD',
                                    hintText: 'Enter Your Password',
                                    border: const OutlineInputBorder(),
                                  ),
                                ),
                                const SizedBox(height: 5.0),
                                Container(
                                  alignment: const Alignment(1.0, 0.0),
                                  padding: const EdgeInsets.only(
                                      top: 15.0, left: 20.0),
                                  child: InkWell(
                                    onTap: () => Navigator.pushNamed(
                                        context, ForgotPaswordScreen.routeName),
                                    child: const Text(
                                      'Forgot Password',
                                      style: TextStyle(
                                        color: Color.fromRGBO(40, 200, 253, 1),
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Montserrat',
                                        letterSpacing: 0.9,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 40.0),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary:
                                        const Color.fromRGBO(40, 200, 253, 1),
                                  ),
                                  onPressed: () => _submitForm(context,
                                      state.status == LoginStatus.submitting),
                                  child: const Padding(
                                    padding: EdgeInsets.all(11.5),
                                    child: Text(
                                      'Sign In',
                                      style: TextStyle(
                                        fontSize: 17.5,
                                        color: Colors.black,
                                        letterSpacing: 1.0,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Montserrat',
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20.0),
                                const Text(
                                  'OR',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 20.0),
                                //if (UniversalPlatform.isIOS)
                                SizedBox(
                                  width: 250.0,
                                  child: SignInWithAppleButton(
                                    onPressed: () {
                                      context.read<LoginCubit>().appleLogin();
                                    },
                                    style: SignInWithAppleButtonStyle.white,
                                  ),
                                ),
                                const SizedBox(height: 20.0),
                                GoogleSignInButton(
                                  onPressed: () =>
                                      context.read<LoginCubit>().googleSignIn(),
                                  title: 'Sign in with Google',
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 25.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const Text(
                                'Need an account?',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Colors.white,
                                  fontSize: 15.0,
                                ),
                              ),
                              const SizedBox(width: 5.0),
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, SignupScreen.routeName);
                                },
                                child: const Text(
                                  'Register',
                                  style: TextStyle(
                                    color: Color.fromRGBO(40, 200, 253, 1),
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
