import 'package:flutter/material.dart';
import 'package:pureair/src/model/aqi.dart';

class PollutantWidget extends StatelessWidget {
  const PollutantWidget({
    Key key,
    @required this.size,
    @required this.title,
    this.value,
  }) : super(key: key);

  final Size size;
  final String title;
  final dynamic value;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final containerSize = size.shortestSide * 0.159;

    return Container(
      height: containerSize.roundToDouble(),
      width: containerSize.roundToDouble(),
      padding: EdgeInsets.symmetric(vertical: 8),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: <Widget>[
          Text(
            title.toUpperCase(),
            style: textTheme.bodyText1.copyWith(
              color: textTheme.overline.color.withOpacity(0.7),
              // fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: 2,
            ),
          ),
          Spacer(),
          Text(
            value.toString(),
            style: textTheme.headline6.copyWith(
              // fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class PollutantList extends StatelessWidget {
  const PollutantList({
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
        PollutantWidget(
            size: size,
            title: 'co',
            value: iaqi.co == null ? '-' : '${iaqi.co.v.round()}'),
        PollutantWidget(
            size: size,
            title: 'no\u2082',
            value: iaqi.no2 == null ? '-' : '${iaqi.no2.v.round()}'),
        PollutantWidget(
            size: size,
            title: '0\u2083',
            value: iaqi.o3 == null ? '-' : '${iaqi.o3.v.round()}'),
        PollutantWidget(
            size: size,
            title: 'pm10',
            value: iaqi.pm10 == null ? '-' : '${iaqi.pm10.v.round()}'),
        PollutantWidget(
            size: size,
            title: 'pm2.5',
            value: iaqi.pm25 == null ? '-' : '${iaqi.pm25.v.round()}'),
        PollutantWidget(
            size: size,
            title: 'so\u2082',
            value: iaqi.so2 == null ? '-' : '${iaqi.so2.v.round()}'),
      ],
    );
  }
}
