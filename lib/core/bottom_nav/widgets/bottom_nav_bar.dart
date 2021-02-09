import 'package:flutter/material.dart';

import 'bottom_nav_bar_item.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    Key key,
    @required this.selectedIndex,
    @required this.items,
    @required this.onSelected,
  }) : super(key: key);

  final int selectedIndex;
  final List<BottomNavBarItem> items;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final theme = Theme.of(context);

    return Container(
      height: size.shortestSide * 0.16,
      width: size.width,
      alignment: Alignment.center,
      color: theme.scaffoldBackgroundColor,
      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items.map((item) {
          var index = items.indexOf(item);
          var _isSelected = index == selectedIndex;
          var _color = !_isSelected ? item.inactiveColor : item.activeColor;

          return GestureDetector(
            onTap: () => onSelected(index),
            child: IconTheme(
              data: IconThemeData(size: 30, color: _color),
              child: item.icon,
            ),
          );
        }).toList(),
      ),
    );
  }
}
