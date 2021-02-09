import 'package:flutter/material.dart';

import '../../../../../../core/helpers/aqi_converter.dart';
import '../../../../../../core/screen_controller/widgets/pollutant_indicator.dart';
import '../../../../../../core/utils/get_dominant_pollutant.dart';
import '../../../../domain/entities/aqi.dart';

class DominantPollutantWidget extends StatelessWidget {
  const DominantPollutantWidget({Key key, @required this.aqi})
      : super(key: key);

  final Aqi aqi;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('DOMINANT POLLUTANT'),
          SizedBox(height: 4),
          _buildRow(theme),
        ],
      ),
    );
  }

  Row _buildRow(ThemeData theme) {
    final domPolIndex = getDomPol(aqi).values.elementAt(0);
    final domPolTitle = getDomPol(aqi).keys.elementAt(0);
    return Row(
      children: [
        PollutantIndicator(
          pollutantIndex: domPolIndex,
          pollutantTitle: domPolTitle,
        ),
        SizedBox(width: 10),
        Expanded(child: _buildDomPolMessage(theme)),
      ],
    );
  }

  Widget _buildDomPolMessage(ThemeData theme) {
    final converter = AqiConverter(aqi: aqi);
    final color = theme.textTheme.bodyText1.color.withOpacity(0.85);

    return Text(
      converter.healthRiskMessage,
      softWrap: true,
      maxLines: 3,
      textAlign: TextAlign.start,
      style: theme.textTheme.bodyText1.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: color,
      ),
    );
  }
}
