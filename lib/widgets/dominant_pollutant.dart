import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:pureair/src/core/aqi_helper.dart';

class DominantPollutant extends StatelessWidget {
  const DominantPollutant({
    Key key,
    @required this.helper,
  }) : super(key: key);

  final AqiHelper helper;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;


    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 5),
        Row(
          children: <Widget>[
            Text(
              'DOMINANT',
              style: textTheme.subtitle1.copyWith(
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
                color: textTheme.subtitle1.color.withOpacity(0.7),
              ),
            ),
            SizedBox(width: 5),
            Container(
              height: 30,
              width: 50,
              padding: EdgeInsets.all(6),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: colorScheme.secondary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: AutoSizeText(
                helper.dominantPol,
                style: textTheme.headline6.copyWith(
                  color: colorScheme.onSecondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 5),
        AutoSizeText(
          helper.healthRisk,
          softWrap: true,
          maxLines: 4,
          minFontSize: 14,
          textAlign: TextAlign.start,
          style: textTheme.headline6.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            letterSpacing: 1.2,
          ),
        ),
      ],
    );
  }
}
