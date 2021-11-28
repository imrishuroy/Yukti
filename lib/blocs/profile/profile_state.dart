part of 'profile_bloc.dart';

enum ProfileStatus { initial, loading, succuss, error }

class ProfileState extends Equatable {
  final AppUser? user;
  final Failure failure;
  final ProfileStatus status;

  const ProfileState({
    required this.user,
    required this.failure,
    required this.status,
  });

  @override
  List<Object?> get props => [user, failure, status];

  factory ProfileState.initial() => const ProfileState(
      user: null, failure: Failure(), status: ProfileStatus.initial);

  ProfileState copyWith({
    AppUser? user,
    Failure? failure,
    ProfileStatus? status,
  }) {
    return ProfileState(
      user: user ?? this.user,
      failure: failure ?? this.failure,
      status: status ?? this.status,
    );
  }
}
