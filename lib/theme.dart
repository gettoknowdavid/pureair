import 'package:flutter/material.dart';

final dividerTheme = DividerThemeData(thickness: 1.2);

const Color primaryDark = const Color(0xFFED44E1);
const Color onPrimaryDark = const Color(0xFFFFFFFF);
const Color secondaryDark = const Color(0xFF2A4CF2);
const Color onSecondaryDark = const Color(0xFFFFFFFF);
const Color backgroundDark = const Color(0xFF252525);
const Color onBackgroundDark = const Color(0xFFFFFFFF);
const Color surfaceDark = const Color(0xFF1E1E1E);
const Color onSurfaceDark = const Color(0xFF898989);

class AppTheme {
  static get theme {
    final ThemeData base = ThemeData.dark();
    return base.copyWith(
      primaryColor: primaryDark,
      scaffoldBackgroundColor: const Color(0xFF101010),
      accentColor: onPrimaryDark,
      colorScheme: ColorScheme.dark(
        primary: primaryDark,
        onPrimary: onPrimaryDark,
        secondary: secondaryDark,
        onSecondary: onSecondaryDark,
        background: backgroundDark,
        onBackground: onBackgroundDark,
        surface: surfaceDark,
        onSurface: onSurfaceDark,
      ),
      canvasColor: Colors.transparent,
      textTheme: _darkTextTheme(base.textTheme),
      accentTextTheme: _darkTextTheme(base.accentTextTheme),
      primaryTextTheme: _darkTextTheme(base.primaryTextTheme),
    );
  }
}

TextTheme _darkTextTheme(TextTheme base) {
  return base
      .copyWith(
        headline1: base.headline1.copyWith(
          color: onBackgroundDark,
          fontWeight: FontWeight.w600,
          // fontSize: 150,
        ),
        headline4: base.headline4.copyWith(
          color: onBackgroundDark,
        ),
        headline5: base.headline5.copyWith(
          fontSize: 23,
        ),
        headline6: base.headline6.copyWith(
          color: onSurfaceDark,
        ),
        subtitle1: base.subtitle1.copyWith(
          color: onSurfaceDark,
          letterSpacing: 2,
        ),
        subtitle2: base.subtitle2.copyWith(
          color: onBackgroundDark,
          fontSize: 21,
          fontWeight: FontWeight.normal,
        ),
        bodyText1: base.bodyText1.copyWith(
          color: onBackgroundDark,
          fontSize: 19,
          fontWeight: FontWeight.normal,
        ),
        bodyText2: base.bodyText2.copyWith(
          color: const Color(0xFF858585),
          letterSpacing: 1,
        ),
        caption: base.caption.copyWith(
          color: const Color(0xFF858585),
          letterSpacing: 1,
          fontSize: 11,
        ),
      )
      .apply(fontFamily: 'ProductSans');
}
