import 'package:flutter/material.dart';
import '../screen_enum.dart';
import '../../../features/aqi/presentation/screens/aqi_screen.dart';
import '../../../features/search/presentation/screens/search_screen.dart';
import '../../../features/settings/presentation/screens/settings_screen.dart';

final ScreenWidget home = ScreenWidget(
  title: 'home',
  screen: ScreenEnum.home,
  widget: AqiScreen(),
);

final ScreenWidget search = ScreenWidget(
  title: 'search',
  screen: ScreenEnum.search,
  widget: SearchScreen(),
);

final ScreenWidget settings = ScreenWidget(
  title: 'settings',
  screen: ScreenEnum.settings,
  widget: SettingsScreen(),
);

class ScreenWidget {
  final String title;
  final ScreenEnum screen;
  final Widget widget;

  ScreenWidget({this.title, this.screen, this.widget});
}
