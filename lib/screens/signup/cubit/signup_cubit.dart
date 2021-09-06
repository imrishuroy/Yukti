import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yukti/models/failure.dart';
import 'package:yukti/respositories/auth/auth_repository.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final AuthRepository _authRepository;

  SignupCubit({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(SignupState.initial());

  // void usernameChanged(String value) {
  //   emit(state.copyWith(username: value, status: SignupStatus.initial));
  // }

  void emailChanged(String value) {
    emit(state.copyWith(email: value, status: SignupStatus.initial));
  }

  void passwordChanged(String value) {
    emit(state.copyWith(password: value, status: SignupStatus.initial));
  }

  void showPassword(bool showPassword) {
    emit(state.copyWith(
        showPassword: !showPassword, status: SignupStatus.initial));
  }

  void signUpWithCredentials() async {
    if (!state.isFormValid || state.status == SignupStatus.submitting) return;
    emit(state.copyWith(status: SignupStatus.submitting));
    try {
      print('Email ${state.email}');
      print('Password ${state.password}');
      await _authRepository.signUpWithEmailAndPassword(
        // username: state.username!,
        email: state.email!,
        password: state.password!,
      );
      emit(state.copyWith(status: SignupStatus.success));
    } on Failure catch (err) {
      emit(state.copyWith(failure: err, status: SignupStatus.error));
    }
  }

  void singupWithGoogle() async {
    try {
      emit(state.copyWith(status: SignupStatus.submitting));
      await _authRepository.signInWithGoogle();
      emit(state.copyWith(status: SignupStatus.success));
    } on Failure catch (error) {
      print('Error sign up google');
      emit(state.copyWith(failure: error, status: SignupStatus.error));
    }
  }
}
