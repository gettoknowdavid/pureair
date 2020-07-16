import 'package:flutter/material.dart';

class PureAirAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PureAirAppBar({
    Key key,
    Size prefferedSize,
    this.title = '',
    this.color,
    this.leading,
    this.actions,
    this.openDrawer,
    // this.isHome,
  })  : prefferedSize = const Size.fromHeight(96),
        super(key: key);

  final Size prefferedSize;
  final String title;
  final Color color;
  final Widget leading;
  final Widget actions;
  final VoidCallback openDrawer;
  // final bool isHome;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final width = MediaQuery.of(context).size.width;

    return Container(
      height: prefferedSize.height,
      width: width,
      decoration: BoxDecoration(
        color: color,
        // boxShadow: [
        //   const BoxShadow(
        //     color: Colors.black12,
        //     blurRadius: 20,
        //   ),
        // ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                leading ?? ImageIcon(AssetImage('images/water.png')),
                actions ?? Container(),
              ],
            ),
            Container(
              alignment: Alignment.center,
              width: width * 0.5,
              child: Text(
                title.toUpperCase(),
                style: textTheme.headline6.copyWith(letterSpacing: 2.0),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => prefferedSize;
}
