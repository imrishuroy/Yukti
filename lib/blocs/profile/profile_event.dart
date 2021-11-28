part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class LoadUserProfile extends ProfileEvent {
  final AppUser user;

  const LoadUserProfile({required this.user});

  @override
  bool? get stringify => true;

  @override
  List<Object> get props => [user];
}

class RefreshProfileUser extends ProfileEvent {}
