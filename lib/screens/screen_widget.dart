import 'package:flutter/material.dart';
import 'package:pureair/screens/home_screen.dart';
import 'package:pureair/screens/search_screen.dart';
import 'package:pureair/screens/settings_screen.dart';
import 'package:pureair/src/model/screen.dart';


final ScreenWidget home = ScreenWidget(title: 'home', screen: Screen.home, widget: HomeScreen());
final ScreenWidget search = ScreenWidget(title: 'search', screen: Screen.search, widget: SearchScreen());
final ScreenWidget settings = ScreenWidget(title: 'settings', screen: Screen.settings, widget: SettingsScreen());

class ScreenWidget {
  final String title;
  final Screen screen;
  final Widget widget;

  ScreenWidget({this.title, this.screen, this.widget});
}


