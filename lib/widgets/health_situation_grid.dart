import 'package:flutter/material.dart';
import 'package:pureair/widgets/pollutant_widget.dart';

class HealthSituationGrid extends StatelessWidget {
  const HealthSituationGrid(
      {Key key, @required this.pollutants, @required this.size})
      : super(key: key);

  final List<Map<String, String>> pollutants;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      primary: false,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 20,
        crossAxisSpacing: 25,
      ),
      itemCount: pollutants.length,
      itemBuilder: (context, index) {
        final titles = pollutants[index].keys;
        final values = pollutants[index].values;

        title() {
          String title;
          for (String _title in titles) {
            switch (_title) {
              case 'co':
                return title = 'CO';
              case 'o3':
                return title = 'O\u2083';
              case 'no2':
                return title = 'NO\u2082';
              case 'pm10':
                return title = 'PM10';
              case 'pm25':
                return title = 'PM2.5';
              default:
                return title = 'SO\u2082';
            }
          }
          return title;
        }

        value() {
          String value;
          for (String _value in values) value = _value;
          return value;
        }

        return PollutantWidget(size: size, title: title(), value: value());
      },
    );
  }
}
