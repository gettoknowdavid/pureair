import 'package:flutter/material.dart';
import 'package:pureair/src/core/aqi_helper.dart';
import 'package:pureair/src/model/aqi.dart';

class PollutantWidget extends StatelessWidget {
  const PollutantWidget({
    Key key,
    @required this.size,
    @required this.title,
    this.backgroundColor,
    this.textColor,
    this.value,
  }) : super(key: key);

  final Size size;
  final String title;
  final Color backgroundColor;
  final Color textColor;
  final dynamic value;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final containerSize = size.shortestSide * 0.159;

    return Container(
      height: containerSize.roundToDouble(),
      width: containerSize.roundToDouble(),
      // padding: EdgeInsets.symmetric(vertical: 10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: backgroundColor ?? colorScheme.background,
        borderRadius: BorderRadius.circular(16),
        border: value.toString().contains('-')
            ? Border.all(color: Colors.transparent)
            : Border.all(
                color: colorScheme.onBackground.withOpacity(0.1),
              ),
        boxShadow: [
          if (!value.toString().contains('-'))
            BoxShadow(
              color: colorScheme.onBackground.withOpacity(0.2),
              blurRadius: 12,
            ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Spacer(),
          Text(
            title.toUpperCase(),
            style: textTheme.bodyText2.copyWith(
              color: textColor != null
                  ? textColor.withOpacity(0.6)
                  : textTheme.overline.color.withOpacity(0.6),
              // fontSize: 16,
              fontWeight: FontWeight.w700,
              letterSpacing: 2,
            ),
          ),
          Spacer(),
          Text(
            value.toString(),
            maxLines: 1,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
            style: textTheme.headline5.copyWith(
              color: textColor ?? colorScheme.onBackground,
              fontWeight: FontWeight.w800,
            ),
          ),
          Spacer(),
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
    AqiHelper helper = AqiHelper(model);

    return GridView(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 20,
        crossAxisSpacing: 25,
      ),
      primary: false,
      children: <Widget>[
        PollutantWidget(
          size: size,
          title: 'co',
          value: iaqi.co == null ? '-' : '${iaqi.co.v.round()}',
          backgroundColor: helper.coPollutantBgColor,
          textColor: helper.coTextColor,
        ),
        PollutantWidget(
          size: size,
          title: 'no\u2082',
          value: iaqi.no2 == null ? '-' : '${iaqi.no2.v.round()}',
          backgroundColor: helper.no2PollutantBgColor,
          textColor: helper.no2TextColor,
        ),
        PollutantWidget(
          size: size,
          title: 'O\u2083',
          value: iaqi.o3 == null ? '-' : '${iaqi.o3.v.round()}',
          backgroundColor: helper.o3PollutantBgColor,
          textColor: helper.o3TextColor,
        ),
        PollutantWidget(
          size: size,
          title: 'pm10',
          value: iaqi.pm10 == null ? '-' : '${iaqi.pm10.v.round()}',
          backgroundColor: helper.pm10PollutantBgColor,
          textColor: helper.pm10TextColor,
        ),
        PollutantWidget(
          size: size,
          title: 'pm2.5',
          value: iaqi.pm25 == null ? '-' : '${iaqi.pm25.v.round()}',
          backgroundColor: helper.pm25PollutantBgColor,
          textColor: helper.pm25TextColor,
        ),
        PollutantWidget(
          size: size,
          title: 'so\u2082',
          value: iaqi.so2 == null ? '-' : '${iaqi.so2.v.round()}',
          backgroundColor: helper.so2PollutantBgColor,
          textColor: helper.so2TextColor,
        ),
      ],
    );
  }
}
