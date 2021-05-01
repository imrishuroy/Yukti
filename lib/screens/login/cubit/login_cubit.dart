import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yukti/models/failure_model.dart';
import 'package:yukti/repositories/auth/auth_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository _authRepository;

  LoginCubit({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(LoginState.initial());

  void emailChanged(String value) {
    emit(state.copyWith(email: value, status: LogInStatus.initial));
  }

  void passwordChanged(String value) {
    emit(state.copyWith(password: value, status: LogInStatus.initial));
  }

  void showPassword(bool showPassword) {
    emit(state.copyWith(
        showPassword: !showPassword, status: LogInStatus.initial));
  }

  void signInWithEmail() async {
    emit(state.copyWith(status: LogInStatus.submitting));
    try {
      await _authRepository.signInWithEmailAndPassword(
        email: state.email,
        password: state.password,
      );
      emit(state.copyWith(status: LogInStatus.succuss));
    } on Failure catch (error) {
      emit(state.copyWith(failure: error, status: LogInStatus.error));
    }
  }

  void googleSignIn() async {
    emit(state.copyWith(status: LogInStatus.submitting));
    try {
      await _authRepository.signInWithGoogle();
      emit(state.copyWith(status: LogInStatus.succuss));
    } on Failure catch (error) {
      emit(state.copyWith(failure: error, status: LogInStatus.error));
    }
  }
}
