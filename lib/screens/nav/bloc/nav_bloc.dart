import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '/enums/nav_item.dart';

part 'nav_event.dart';

class NavBloc extends Bloc<NavEvent, NavItem> {
  NavBloc() : super(NavItem.dashboard);

  @override
  Stream<NavItem> mapEventToState(
    NavEvent event,
  ) async* {
    if (event is UpdateNavItem) {
      yield event.item;
    }
  }
}
