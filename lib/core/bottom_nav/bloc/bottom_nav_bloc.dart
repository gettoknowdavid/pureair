import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../screen_controller/screen_enum.dart';
import '../../screen_controller/widgets/screen_widget.dart';

part 'bottom_nav_event.dart';
part 'bottom_nav_state.dart';

class BottomNavBloc extends Bloc<BottomNavEvent, BottomNavState> {
  BottomNavBloc() : super(BottomNavState(home));

  @override
  Stream<BottomNavState> mapEventToState(
    BottomNavEvent event,
  ) async* {
    if (event is UpdateBottomNav) {
      yield BottomNavState(_widget(event.screen));
    }
  }

  ScreenWidget _widget(ScreenEnum screen) {
    switch (screen) {
      case ScreenEnum.home:
        return home;
      case ScreenEnum.search:
        return search;
      default:
        return settings;
    }
  }
}
