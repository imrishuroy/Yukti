part of 'signup_cubit.dart';

enum SignUpStatus { initial, submitting, succuss, error }

class SignupState extends Equatable {
  final String email;
  final String password;
  final SignUpStatus status;
  final Failure failure;

  SignupState({
    required this.email,
    required this.password,
    required this.status,
    required this.failure,
  });

  @override
  List<Object> get props => [email, password, status, failure];
  @override
  bool get stringify => true;

  bool get isFormValid => email.isNotEmpty && password.isNotEmpty;

  factory SignupState.initial() => SignupState(
      email: '',
      password: '',
      status: SignUpStatus.initial,
      failure: const Failure());

  SignupState copyWith({
    String? email,
    String? password,
    SignUpStatus? status,
    Failure? failure,
  }) {
    return SignupState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }
}