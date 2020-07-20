import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:pureair/src/model/aqi.dart';

class WeatherWidget extends StatelessWidget {
  const WeatherWidget({
    Key key,
    @required this.size,
    @required this.icon,
    @required this.value,
    @required this.unit,
  }) : super(key: key);

  final Size size;
  final String icon;
  final dynamic value;
  final dynamic unit;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final containerWidth = size.shortestSide * 0.159;
    final containerHeight = containerWidth * 2;

    return Container(
      height: containerHeight.roundToDouble(),
      width: containerWidth.roundToDouble(),
      padding: EdgeInsets.symmetric(vertical: 16),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colorScheme.background.withOpacity(0.1),
        ),
        boxShadow: [
          BoxShadow(
            color: colorScheme.onBackground.withOpacity(0.2),
            blurRadius: 14,
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          ImageIcon(
            AssetImage(icon),
            color: colorScheme.onBackground.withOpacity(0.7),
          ),
          Spacer(),
          AutoSizeText(
            value.toString(),
            style: textTheme.headline5.copyWith(
              fontWeight: FontWeight.w800,
              color: colorScheme.onBackground,
            ),
          ),
          Spacer(),
          AutoSizeText(
            unit,
            style: textTheme.headline6.copyWith(
              color: colorScheme.onBackground.withOpacity(0.7),
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: 2,
            ),
          ),
        ],
      ),
    );
  }
}

class WeatherList extends StatelessWidget {
  const WeatherList({
    Key key,
    @required this.size,
    @required this.model,
  }) : super(key: key);

  final Size size;
  final Aqi model;

  @override
  Widget build(BuildContext context) {
    final iaqi = model.data.iaqi;

    return Wrap(
      runSpacing: 20,
      spacing: ((size.width - 56) - ((size.shortestSide * 0.159) * 4)) / 2.9,
      children: <Widget>[
        WeatherWidget(
          size: size,
          icon: 'images/cloud.png',
          value: iaqi.t == null ? '-' : '${iaqi.t.v.round()}',
          unit: 'C\u00B0',
        ),
        WeatherWidget(
          size: size,
          icon: 'images/drop.png',
          value: iaqi.h == null ? '-' : '${iaqi.h.v.round()}',
          unit: '%Hum.',
        ),
        WeatherWidget(
          size: size,
          icon: 'images/umbrella.png',
          value: iaqi.p == null ? '-' : '${iaqi.p.v.round()}',
          unit: 'ATM',
        ),
        WeatherWidget(
          size: size,
          icon: 'images/wind.png',
          value: iaqi.w == null ? '-' : '${iaqi.w.v.round()}',
          unit: 'km/h',
        ),
      ],
    );
  }
}
