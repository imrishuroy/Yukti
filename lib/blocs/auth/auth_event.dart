part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  bool? get stringify => true;

  @override
  List<Object> get props => [];
}

class AuthUserChanged extends AuthEvent {
  final AppUser? user;

  AuthUserChanged({@required this.user});
}

class LogoutRequested extends AuthEvent {}
