import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../../../../core/utils/aqi_level.dart';
import '../../../../core/utils/pollution_level.dart';
import '../../domain/entities/aqi.dart';

class AqiIndexWidget extends StatelessWidget {
  const AqiIndexWidget({Key key, @required this.aqi}) : super(key: key);
  final Aqi aqi;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    final index = aqi.data.aqi;

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Container(
        height: size.longestSide * 0.39,
        child: SfRadialGauge(
          axes: <RadialAxis>[
            RadialAxis(
              minimum: 0,
              maximum: 500,
              showLabels: false,
              showTicks: false,
              axisLineStyle: AxisLineStyle(
                color: Color(0xFF252525),
                cornerStyle: CornerStyle.bothCurve,
                thickness: 0.11,
                thicknessUnit: GaugeSizeUnit.factor,
              ),
              pointers: _pointers(index.toDouble()),
              annotations: <GaugeAnnotation>[
                _buildIndexAnnotation(theme, index),
                _buildLevelAnnotation(size.longestSide, theme),
              ],
            )
          ],
        ),
      ),
    );
  }

  GaugeAnnotation _buildLevelAnnotation(double width, ThemeData theme) {
    final level = getLevel(aqi.data.aqi);

    return GaugeAnnotation(
      positionFactor: 0.62,
      angle: 90,
      widget: Container(
        width: width * 0.2,
        child: Text(
          level.pollutionLevelToString,
          maxLines: 2,
          textAlign: TextAlign.center,
          style: theme.textTheme.subtitle2,
        ),
      ),
    );
  }

  GaugeAnnotation _buildIndexAnnotation(ThemeData theme, int index) {
    return GaugeAnnotation(
      positionFactor: 0,
      angle: 90,
      widget: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('USAQI', style: theme.textTheme.subtitle1),
          Text('$index', style: theme.textTheme.headline1),
        ],
      ),
    );
  }

  List<GaugePointer> _pointers(double index) {
    final List<GaugePointer> _pointers = [];

    for (AqiLevel level in levels.reversed) {
      bool _isHarzadous = level.pollutionLevel == PollutionLevel.harzadous;
      var _maxValue = _isHarzadous ? index : level.maxValue;
      var _nextColor1 =
          index < level.excessValue ? level.color : level.nextColor;
      var _nextColor2 = level.nextColor;

      _pointers.add(
        RangePointer(
          value: index < level.excessValue ? index : _maxValue,
          cornerStyle: CornerStyle.bothCurve,
          width: 0.11,
          sizeUnit: GaugeSizeUnit.factor,
          enableAnimation: true,
          animationDuration: 1800,
          gradient: SweepGradient(
            colors: <Color>[
              level.firstColor,
              _isHarzadous ? _nextColor2 : _nextColor1
            ],
            stops: <double>[0.4, 0.9],
          ),
        ),
      );
    }
    return _pointers;
  }
}
