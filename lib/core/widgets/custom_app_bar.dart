import 'package:flutter/material.dart';

import '../utils/pureaire_icons.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key key,
    Size prefferedSize,
    this.title = '',
    this.color,
    this.leading,
    this.actions,
    this.openDrawer,
  })  : prefferedSize = const Size.fromHeight(96),
        super(key: key);

  final Size prefferedSize;
  final String title;
  final Color color;
  final Widget leading;
  final Widget actions;
  final VoidCallback openDrawer;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);

    return Container(
      height: prefferedSize.height,
      width: width,
      color: theme.appBarTheme.color,
      padding: EdgeInsets.symmetric(horizontal: 26.0),
      child: _buildStack(context),
    );
  }

  Widget _buildStack(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            _buildRow(context),
            _buildTitle(context),
          ],
        ),
      ),
    );
  }

  Row _buildRow(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        leading ?? ImageIcon(water, color: colorScheme.primary),
        actions ?? Container(),
      ],
    );
  }

  Widget _buildTitle(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    final width = MediaQuery.of(context).size.width;

    return Container(
      alignment: Alignment.center,
      width: width * 0.5,
      child: Text(
        title.toUpperCase(),
        style: textTheme.headline6.copyWith(
          letterSpacing: 2.0,
          color: colorScheme.onBackground,
          fontSize: 17.5,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => prefferedSize;
}
