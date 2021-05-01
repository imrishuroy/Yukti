import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:yukti/screens/nav/bottom_nav_item_enum.dart';

part 'bottom_nav_bar_state.dart';

class BottomNavBarCubit extends Cubit<BottomNavBarState> {
  BottomNavBarCubit()
      : super(BottomNavBarState(selectedItem: BottomNavItem.dashbaord));

  void updateSelectedItem(BottomNavItem selectedItem) {
    if (selectedItem != state.selectedItem) {
      emit(BottomNavBarState(selectedItem: selectedItem));
    }
  }
}
