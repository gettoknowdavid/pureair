import 'package:flutter/material.dart';

class BottomNavBarItem {
  final Widget icon;
  final Text title;
  final Color activeColor;
  final Color inactiveColor;

  const BottomNavBarItem({
    this.icon,
    @required this.title,
    this.activeColor,
    this.inactiveColor,
  }) : assert(title != null);
}
