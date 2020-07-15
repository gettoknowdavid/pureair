import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pureair/src/core/db_repository.dart';
import 'package:pureair/src/model/pure_air_theme.dart';
import 'package:pureair/themes.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeLoading());

  final DbRepository repository = DbRepository();

  @override
  Stream<ThemeState> mapEventToState(
    ThemeEvent event,
  ) async* {
    if (event is LoadTheme) {
      try {
        PureAirTheme pureAirTheme = await repository.loadTheme;
        yield ThemeLoaded(theme: pureAirThemes[pureAirTheme.theme]);
        print(
            'LOADDDDD______THEMMMMMMMMMMMMMMMMEEEEE::::::${pureAirTheme.theme}');
      } catch (_) {
        yield ThemeLoaded(theme: pureAirThemes[ThemeEnum.lightTheme]);
      }
    } else if (event is ChangeTheme) {
      PureAirTheme _theme = PureAirTheme(event.theme);
      print(event.theme);
      yield ThemeLoaded(theme: pureAirThemes[event.theme]);

      await repository.clearThemeStore;
      await repository.saveTheme(_theme);

      PureAirTheme theme2 = await repository.loadTheme;
      print('THEMMMMMMMMMMMMMMMMEEEEE::::::${theme2.theme}');
    }
  }
}
