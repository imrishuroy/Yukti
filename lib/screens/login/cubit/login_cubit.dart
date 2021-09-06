import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:yukti/models/failure.dart';
import 'package:yukti/respositories/auth/auth_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository _authRepository;

  LoginCubit({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(LoginState.initial());

  void emailChanged(String value) {
    emit(state.copyWith(email: value, status: LoginStatus.initial));
  }

  void passwordChanged(String value) {
    emit(state.copyWith(password: value, status: LoginStatus.initial));
  }

  void showPassword(bool showPassword) {
    emit(state.copyWith(
        showPassword: !showPassword, status: LoginStatus.initial));
  }

  void signInWithEmail() async {
    emit(state.copyWith(status: LoginStatus.submitting));
    try {
      await _authRepository.loginInWithEmailAndPassword(
        email: state.email,
        password: state.password,
      );
      emit(state.copyWith(status: LoginStatus.succuss));
    } on Failure catch (error) {
      emit(state.copyWith(failure: error, status: LoginStatus.error));
    }
  }

  void googleSignIn() async {
    emit(state.copyWith(status: LoginStatus.submitting));
    try {
      await _authRepository.signInWithGoogle();
      emit(state.copyWith(status: LoginStatus.succuss));
    } on Failure catch (error) {
      emit(state.copyWith(failure: error, status: LoginStatus.error));
    }
  }
}
