import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '/constants/constants.dart';
import '/respositories/auth/auth_repository.dart';
import '/screens/signup/cubit/signup_cubit.dart';
import '/widgets/error_dialog.dart';
import '/widgets/google_button.dart';
import '/widgets/greetings_widget.dart';

class SignupScreen extends StatelessWidget {
  static const String routeName = '/signup';

  SignupScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => BlocProvider<SignupCubit>(
        create: (context) => SignupCubit(
          authRepository: context.read<AuthRepository>(),
        ),
        child: SignupScreen(),
      ),
    );
  }

  final _formKey = GlobalKey<FormState>();

  void _submitForm(BuildContext context, bool isSubmitting) {
    if (_formKey.currentState!.validate() && !isSubmitting) {
      context.read<SignupCubit>().signUpWithCredentials();
      //showSnackBar(context: context, title: 'SignUp Succussfull');
    }
  }

  void showSnackBar({BuildContext? context, String? title}) {
    ScaffoldMessenger.of(context!).showSnackBar(
      SnackBar(
          duration: const Duration(seconds: 3),
          content: Text(
            '$title',
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.green),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      //  backgroundColor: const Color.fromRGBO(29, 38, 40, 1),
      body: BlocConsumer<SignupCubit, SignupState>(
        listener: (context, state) {
          print('Current state ${state.status}');
          if (state.status == SignupStatus.error) {
            showDialog(
              context: context,
              builder: (context) => ErrorDialog(
                content: state.failure.message,
              ),
            );
          }
        },
        builder: (context, state) {
          return state.status == SignupStatus.submitting
              ? const Center(child: CircularProgressIndicator())
              : Form(
                  key: _formKey,
                  child: ListView(
                    children: <Widget>[
                      GreetingsWidget(height: height),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 22.0, left: 20.0, right: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            TextFormField(
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 16.0),
                              onChanged: (value) => context
                                  .read<SignupCubit>()
                                  .emailChanged(value),

                              // onSaved: (value) => email = value,
                              keyboardType: TextInputType.emailAddress,
                              //  controller: textController,
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
                            // EmailField(
                            //   textController: _emailController,
                            // ),
                            const SizedBox(height: 25.0),
                            // PasswordField(
                            //   textController: _passwordController,
                            // ),
                            TextFormField(
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 16.0),
                              key: key,
                              obscureText: !state.showPassword,
                              onChanged: (value) => context
                                  .read<SignupCubit>()
                                  .passwordChanged(value),
                              //  obscureText: _hidePassword,
                              //  controller: widget.textController,
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
                                prefixIcon:
                                    const Icon(Icons.lock, color: Colors.white),
                                suffixIcon: IconButton(
                                  color: Colors.white,
                                  icon: Icon(
                                    state.showPassword
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                  onPressed: () {
                                    context
                                        .read<SignupCubit>()
                                        .showPassword(state.showPassword);
                                  },
                                ),
                                hintStyle: const TextStyle(color: Colors.white),
                                labelText: 'PASSWORD',
                                hintText: 'Enter Your Password',
                                border: const OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(height: 55.0),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: primaryColor,
                              ),
                              onPressed: () => _submitForm(
                                context,
                                state.status == SignupStatus.submitting,
                              ), //onPressed: () => _registerUser(context),
                              child: const Padding(
                                padding: EdgeInsets.all(11.5),
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
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: SizedBox(
                          width: 250.0,
                          child: SignInWithAppleButton(
                            onPressed: () =>
                                context.read<SignupCubit>().appleLogin(),
                            style: SignInWithAppleButtonStyle.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: GoogleSignInButton(
                          onPressed: () =>
                              context.read<SignupCubit>().singupWithGoogle(),
                          //  onPressed: () => googleSignIn(context),
                          title: 'Register with Google',
                        ),
                      ),
                      const SizedBox(height: 35.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Have an Account?',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                            ),
                          ),
                          const SizedBox(width: 5.0),
                          GestureDetector(
                            onTap: () => Navigator.of(context).pop(),
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                color: primaryColor,
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
                );
        },
      ),
    );
  }
}
