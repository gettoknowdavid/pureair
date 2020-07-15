import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pureair/screens/screen_widget.dart';
import 'package:pureair/src/model/screen.dart';

part 'tabs_event.dart';
part 'tabs_state.dart';

class TabsBloc extends Bloc<TabsEvent, TabsState> {
  TabsBloc() : super(TabsState(home));


  @override
  Stream<TabsState> mapEventToState(
    TabsEvent event,
  ) async* {
    if (event is UpdateTab) {
      yield TabsState(_widget(event.screen));
    }
  }

  ScreenWidget _widget(Screen screen) {
    switch (screen) {
      case Screen.home:
        return home;
        break;
      case Screen.search:
        return search;
        break;
      default:
        return settings;
    }
  }
}
