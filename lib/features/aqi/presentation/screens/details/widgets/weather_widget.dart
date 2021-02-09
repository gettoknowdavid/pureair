import 'package:flutter/material.dart';

class WeatherWidget extends StatelessWidget {
  const WeatherWidget({
    Key key,
    @required this.assetImage,
    @required this.value,
    @required this.unit,
  }) : super(key: key);

  final ExactAssetImage assetImage;
  final dynamic value;
  final dynamic unit;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final containerWidth = size.shortestSide * 0.16;
    final containerHeight = containerWidth * 2.0;

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Container(
        height: containerHeight,
        width: containerWidth,
        padding: EdgeInsets.symmetric(vertical: 16),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(60),
          gradient: LinearGradient(
            colors: [colorScheme.primary, colorScheme.secondary],
            begin: Alignment.topLeft,
            stops: [0.4, 1.0],
          ),
        ),
        child: _buildColumn(textTheme, colorScheme),
      ),
    );
  }

  Widget _buildColumn(TextTheme textTheme, ColorScheme colorScheme) {
    final _color = colorScheme.onBackground.withOpacity(0.8);

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        ImageIcon(assetImage, color: _color),
        _buildValue(textTheme, colorScheme),
        _buildUnit(textTheme, colorScheme),
      ],
    );
  }

  Widget _buildValue(TextTheme textTheme, ColorScheme colorScheme) {
    return Text(
      value.toString(),
      style: textTheme.headline6.copyWith(
        fontWeight: FontWeight.w600,
        color: colorScheme.onPrimary,
        
      ),
    );
  }

  Widget _buildUnit(TextTheme textTheme, ColorScheme colorScheme) {
    return Text(
      unit,
      style: textTheme.subtitle1.copyWith(
        color: colorScheme.onBackground.withOpacity(0.8),
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
        fontSize: 15,
      ),
    );
  }
}
