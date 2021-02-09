import 'package:flutter/material.dart';

import '../../../../../../core/utils/pureaire_icons.dart';
import '../../../../domain/entities/aqi.dart';
import 'weather_widget.dart';

class WeatherList extends StatelessWidget {
  const WeatherList({Key key, @required this.aqi}) : super(key: key);

  final Aqi aqi;

  @override
  Widget build(BuildContext context) {
    final iaqi = aqi.data.iaqi;
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('WEATHER', style: theme.textTheme.headline6),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            WeatherWidget(
              assetImage: cloud,
              value: iaqi.t == null ? '-' : '${iaqi.t.v.round()}',
              unit: 'C\u00B0',
            ),
            WeatherWidget(
              assetImage: drop,
              value: iaqi.h == null ? '-' : '${iaqi.h.v.round()}',
              unit: '%Hum.',
            ),
            WeatherWidget(
              assetImage: umbrella,
              value: iaqi.p == null ? '-' : '${iaqi.p.v.round()}',
              unit: 'ATM',
            ),
            WeatherWidget(
              assetImage: wind,
              value: iaqi.w == null ? '-' : '${iaqi.w.v.round()}',
              unit: 'km/h',
            ),
          ],
        ),
      ],
    );
  }
}
