part of 'login_cubit.dart';

enum LogInStatus { initial, submitting, succuss, error }

class LoginState extends Equatable {
  final String email;
  final String password;
  final LogInStatus status;
  final Failure failure;
  final bool showPassword;

  const LoginState({
    required this.email,
    required this.password,
    required this.showPassword,
    required this.failure,
    required this.status,
  });

  @override
  List<Object?> get props => [email, password, showPassword, failure, status];

  @override
  bool? get stringify => true;

  bool get isFormValid => email.isNotEmpty && password.isNotEmpty;

  factory LoginState.initial() {
    return LoginState(
      email: '',
      password: '',
      showPassword: false,
      status: LogInStatus.initial,
      failure: Failure(),
    );
  }

  LoginState copyWith({
    String? email,
    String? password,
    LogInStatus? status,
    Failure? failure,
    bool? showPassword,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      failure: failure ?? this.failure,
      showPassword: showPassword ?? this.showPassword,
    );
  }
}
