import 'package:flutter/material.dart';

import '../../utils/aqi_level.dart';
import 'pollutant_painter.dart';

class PollutionBarIndicator extends StatelessWidget {
  const PollutionBarIndicator({
    Key key,
    @required this.pollutantIndex,
    @required this.height,
    @required this.width,
    this.color,
  }) : super(key: key);

  final int pollutantIndex;
  final double height;
  final double width;
  final Color color;

  @override
  Widget build(BuildContext context) {
    var level = getLevel(pollutantIndex);

    return RotatedBox(
      quarterTurns: 2,
      child: CustomPaint(
        painter: PollutantPainter(
          index: pollutantIndex > 500 ? 500 : pollutantIndex,
          color: color ?? level.color,
        ),
        child: Container(height: height * 0.55, width: 4),
      ),
    );
  }
}
