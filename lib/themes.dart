import 'package:flutter/material.dart';

TextTheme _textTheme(TextTheme base) {
  return base.copyWith().apply(fontFamily: 'ProductSans');
}

// IconThemeData _iconTheme(IconThemeData base) {
//   return base.copyWith(
//     color: 
//   );
// }

const Color _primary = const Color(0xFF0460D9);
const Color _primaryVariant = const Color(0xFF0476D9);
const Color _secondary = const Color(0xFFF24F13);
const Color _secondaryVariant = const Color(0xFF1E3E59);
const Color _onPrimary = const Color(0xFFF2F2F2);
const Color _onSecondary = const Color(0xFFF2F2F2);
const Color _onBackground = const Color(0xFF1E3E59);
const Color _onSurface = const Color(0xFF1E3E59);
const Color _error = const Color(0xFF1E3E59);
const Color _onError = const Color(0xFFF2F2F2);
const Color _background = const Color(0xFFFFFFFF);
const Color _surface = const Color(0xFFFFFFFF);

// final ThemeData kLightTheme = _buildLightTheme;

final dividerTheme = DividerThemeData(thickness: 1.2);

ThemeData get _buildLightTheme {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    colorScheme: ColorScheme(
      primary: _primary,
      primaryVariant: _primaryVariant,
      secondary: _secondary,
      secondaryVariant: _secondaryVariant,
      error: _error,
      background: _background,
      surface: _surface,
      onPrimary: _onPrimary,
      onSecondary: _onSecondary,
      onBackground: _onBackground,
      onSurface: _onSurface,
      onError: _onError,
      brightness: Brightness.light,
    ),
    dividerColor: _secondaryVariant.withOpacity(0.1),
    scaffoldBackgroundColor: _background,
    bottomAppBarColor: Colors.transparent,
    dividerTheme: dividerTheme,
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
