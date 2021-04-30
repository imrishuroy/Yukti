import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:yukti/models/failure_model.dart';
import 'package:yukti/repositories/auth/auth_repository.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final AuthRepository? _authRepository;

  SignupCubit({@required AuthRepository? authRepository})
      : _authRepository = authRepository,
        super(SignupState.initial());

  void emailChanged(String value) {
    emit(state.copyWith(email: value, status: SignUpStatus.initial));
  }

  void passwordChanges(String value) {
    emit(state.copyWith(password: value, status: SignUpStatus.initial));
  }

  void signUpWithCredentials() async {
    if (!state.isFormValid || state.status == SignUpStatus.submitting) return;
    emit(state.copyWith(status: SignUpStatus.submitting));
    try {
      await _authRepository?.createUserWithEmailAndPassword(
        email: state.email,
        password: state.password,
      );
      emit(state.copyWith(status: SignUpStatus.succuss));
    } on Failure catch (error) {
      print('Error: $error');
      emit(state.copyWith(failure: error, status: SignUpStatus.error));
    }
  }
}
