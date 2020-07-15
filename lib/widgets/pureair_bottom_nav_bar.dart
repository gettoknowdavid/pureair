import 'package:flutter/material.dart';

class PureAirBottomNavBar extends StatelessWidget {
  final Size size;
  final Color backgroundColor;
  final bool showElevation;
  final int selectedIndex;
  final List<PureBottomBarItem> items;
  final ValueChanged<int> onSelected;

  const PureAirBottomNavBar({
    Key key,
    @required this.size,
    @required this.selectedIndex,
    @required this.items,
    this.onSelected,
    this.backgroundColor,
    this.showElevation = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      height: size.shortestSide * 0.17,
      width: size.width,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: backgroundColor ?? colorScheme.surface,
        boxShadow: [
          if (showElevation)
            const BoxShadow(
              color: Colors.black12,
              blurRadius: 20,
            ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items.map((item) {
          var index = items.indexOf(item);
          return GestureDetector(
            onTap: () => onSelected(index),
            child: AnimatedItem(
              size: size,
              item: item,
              isSelected: index == selectedIndex,
            ),
          );
        }).toList(),
      ),
    );
  }
}

class AnimatedItem extends StatelessWidget {
  final Size size;
  final double height;
  final double width;
  final bool isSelected;
  final PureBottomBarItem item;

  const AnimatedItem({
    Key key,
    @required this.size,
    this.height,
    this.width,
    this.isSelected,
    this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final textTheme = Theme.of(context).textTheme;
    return Semantics(
      container: true,
      selected: isSelected,
      child: Container(
        width: 60,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            IconTheme(
              data: IconThemeData(
                  size: 30,
                  color: !isSelected
                      ? Theme.of(context).iconTheme.color.withOpacity(0.4)
                      : Theme.of(context).iconTheme.color),
              child: item.icon,
            ),
          ],
        ),
      ),
    );
  }
}

class PureBottomBarItem {
  final Widget icon;
  final Text title;
  final Color activeColor;
  final Color inactiveColor;
  final TextAlign textAlign;

  const PureBottomBarItem({
    this.icon,
    @required this.title,
    this.activeColor,
    this.inactiveColor,
    this.textAlign,
  }) : assert(title != null);
}
