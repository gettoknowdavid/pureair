import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class OtherWidgetsList extends StatelessWidget {
  const OtherWidgetsList({
    Key key,
    @required this.height,
    @required this.width,
  }) : super(key: key);

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    final widgetContainerHeight = height * 0.9;

    return Container(
      height: height,
      // color: Colors.pink,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
      padding: EdgeInsets.only(right: 20),

        child: Row(
          children: <Widget>[
            OtherWidgetItem(
              height: widgetContainerHeight,
              width: width,
              title: 'Air Quality',
              child: Container(),
            ),
            OtherWidgetItem(
              height: widgetContainerHeight,
              width: width,
              title: 'Dominant Pollutant',
              child: Container(),
            ),
            OtherWidgetItem(
              height: widgetContainerHeight,
              width: width,
              title: 'Map',
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }
}

class OtherWidgetItem extends StatelessWidget {
  const OtherWidgetItem({
    Key key,
    @required this.height,
    @required this.width,
    @required this.title,
    @required this.child,
  }) : super(key: key);

  final double height;
  final double width;
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      height: height,
      width: width,
      margin: EdgeInsets.only(left: 20),
      child: Material(
        elevation: 6,
        shadowColor: Colors.black26,
        color: colorScheme.surface,
        // color: Color(0xFFF3F5FA),
        borderRadius: BorderRadius.circular(30),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: <Widget>[
              AutoSizeText(
                title,
                textAlign: TextAlign.center,
                maxLines: 2,
                maxFontSize: 28,
                minFontSize: 20,
                style: textTheme.headline5.copyWith(
                  color: colorScheme.onSurface.withOpacity(0.6),
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'Not Supported',
                style: textTheme.headline6.copyWith(
                  fontWeight: FontWeight.w400,
                ),
              ),
              Expanded(child: child),
            ],
          ),
        ),
      ),
    );
  }
}
