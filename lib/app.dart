import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pureair/blocs/theme/theme_bloc.dart';
import 'package:pureair/screens/screen_controller.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return BlocProvider(
      create: (context) => ThemeBloc()..add(LoadTheme()),
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          if (state is ThemeLoaded) {
            return MaterialApp(
              theme: state.theme,
              debugShowCheckedModeBanner: false,
              home: ScreenController(),
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
