import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yukti/blocs/auth/auth_bloc.dart';
import 'package:yukti/models/app_user.dart';
import 'package:yukti/models/failure.dart';
import 'package:yukti/respositories/user/user_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final AuthBloc _authBloc;
  final UserRepository _userRepository;
  StreamSubscription? _profileSubscription;

  ProfileBloc({
    required AuthBloc authBloc,
    required UserRepository userRepository,
  })  : _authBloc = authBloc,
        _userRepository = userRepository,
        super(ProfileState.initial()) {
    _profileSubscription?.cancel();
    _profileSubscription = _userRepository
        .streamUserById(userId: _authBloc.state.user?.uid)
        .listen((user) {
      if (user != null) {
        print('out user $user');
        add(LoadUserProfile(user: user));
      }
    });

    on<LoadUserProfile>(_onEventLoadProfileUser);
    on<RefreshProfileUser>(_onRefreshProfileUser);
  }

  @override
  Future<void> close() {
    _profileSubscription?.cancel();
    return super.close();
  }

  void _onEventLoadProfileUser(
      LoadUserProfile event, Emitter<ProfileState> emit) {
    print('Event -- ${event.user}');
    emit(state.copyWith(user: event.user, status: ProfileStatus.succuss));
  }

  void _onRefreshProfileUser(
      RefreshProfileUser event, Emitter<ProfileState> emit) {
    _profileSubscription?.cancel();
    _profileSubscription = _userRepository
        .streamUserById(userId: _authBloc.state.user?.uid)
        .listen((user) => add(LoadUserProfile(user: user!)));
  }
}
