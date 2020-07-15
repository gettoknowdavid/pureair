import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  const Background(
      {Key key, this.appBar, this.child, this.backgroundColor, this.padding})
      : super(key: key);

  final Widget child;
  final PreferredSizeWidget appBar;
  final Color backgroundColor;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    final appBarHeight = size.shortestSide * 0.2;

    final containerHeight = size.longestSide - appBarHeight;
    // final containerWidth = width * 0.93;

    // final sidePadding = (size.shortestSide - containerWidth) / 2;

    return Scaffold(
      appBar: appBar,
      backgroundColor: backgroundColor,
      body: Container(
        height: height,
        width: width,
        alignment: Alignment.bottomCenter,
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(60),
          ),
          child: Container(
            height: containerHeight,
            width: width,
            // padding: padding ?? EdgeInsets.symmetric(horizontal: sidePadding),
            padding: padding,
            // color: Colors.white,
            child: child,
          ),
        ),
      ),
    );
  }
}
