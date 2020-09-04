import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:pureair/blocs/theme/theme_bloc.dart';
import 'package:pureair/src/core/db_repository.dart';
import 'package:pureair/widgets/pure_air_splash_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return BlocProvider(
      create: (context) => ThemeBloc(DbRepository())..add(LoadTheme()),
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          if (state is ThemeLoaded) {
            return OverlaySupport(
              child: MaterialApp(
                theme: state.theme,
                debugShowCheckedModeBanner: false,
                home: PureAirSplashScreen(),
              ),
            );
          } else {
            return Material(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}

