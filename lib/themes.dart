import 'package:flutter/material.dart';

TextTheme _textTheme(TextTheme base) {
  return base.apply(fontFamily: 'ProductSans', fontSizeFactor: 1.0);
}

// final ThemeData kLightTheme = _buildLightTheme;

final dividerTheme = DividerThemeData(thickness: 1.2);

ThemeData get _buildLightTheme {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    bottomAppBarColor: Colors.transparent,
    dividerTheme: dividerTheme,
    canvasColor: Colors.transparent,
    textTheme: _textTheme(base.textTheme),
    accentTextTheme: _textTheme(base.accentTextTheme),
    primaryTextTheme: _textTheme(base.primaryTextTheme),
  );
}

final ThemeData kDarkTheme = _buildDarkTheme;

ThemeData get _buildDarkTheme {
  final ThemeData base = ThemeData.dark();
  return base.copyWith(
    dividerTheme: dividerTheme,
    canvasColor: Colors.transparent,
    textTheme: _textTheme(base.textTheme),
    accentTextTheme: _textTheme(base.accentTextTheme),
    primaryTextTheme: _textTheme(base.primaryTextTheme),
  );
}

enum ThemeEnum { lightTheme, darkTheme }

final pureAirThemes = {
  ThemeEnum.lightTheme: _buildLightTheme,
  ThemeEnum.darkTheme: _buildDarkTheme,
};
