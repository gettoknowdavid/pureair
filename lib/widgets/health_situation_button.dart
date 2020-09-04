import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:pureair/screens/select_health_condition.dart';
import 'package:pureair/src/model/health_situation.dart';
import 'package:pureair/widgets/fade_page_route.dart';

class HealthSituationButton extends StatelessWidget {
  const HealthSituationButton({Key key, @required this.situation})
      : super(key: key);

  final SituationEnum situation;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      height: 36,
      padding: EdgeInsets.all(6),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: colorScheme.secondary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: situation.index != 0
          ? AutoSizeText(
              enumToString(situation),
              style: textTheme.headline6.copyWith(
                color: colorScheme.onSecondary,
                fontWeight: FontWeight.bold,
              ),
            )
          : GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  FadePageRoute(widget: SelectHealthCondition()),
                );
              },
              child: AutoSizeText(
                'Click to select a health situation',
                style: textTheme.headline6.copyWith(
                  color: colorScheme.onSecondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
    );
  }
}
