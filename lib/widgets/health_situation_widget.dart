import 'package:flutter/material.dart';
import 'package:pureair/src/model/health_situation.dart';
import 'package:pureair/widgets/health_situation_button.dart';
import 'package:pureair/widgets/health_situation_grid.dart';

class HealthSituationWidget extends StatelessWidget {
  const HealthSituationWidget({
    Key key,
    @required this.message,
    @required this.pollutants,
    @required this.situation,
    @required this.size,
  }) : super(key: key);

  final String message;
  final List<Map<String, String>> pollutants;
  final SituationEnum situation;
  final Size size;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        HealthSituationButton(situation: situation),
        SizedBox(height: 30),
        situation.index != 0
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '$message',
                    style: textTheme.headline6,
                  ),
                  SizedBox(height: 30),
                  LimitedBox(
                    child: HealthSituationGrid(
                      pollutants: pollutants,
                      size: size,
                    ),
                  ),
                ],
              )
            : Container(
                child: Text(
                  'Select your preferred health situation to see air pollutants tailored to your health situation.',
                  style: textTheme.bodyText2.copyWith(
                    fontSize: 18,
                    color: colorScheme.onBackground.withOpacity(0.7),
                  ),
                ),
              ),
      ],
    );
  }
}
