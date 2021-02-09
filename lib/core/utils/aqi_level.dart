import 'dart:ui';

import 'aqi_colors.dart';
import 'pollution_level.dart';

class AqiLevel {
  final PollutionLevel pollutionLevel;
  final String pollutionLevelToString;
  final double maxValue;
  final double excessValue;
  final Color color;
  final Color firstColor;
  final Color nextColor;

  const AqiLevel._internal(
    this.pollutionLevel,
    this.pollutionLevelToString,
    this.maxValue,
    this.excessValue,
    this.color,
    this.firstColor,
    this.nextColor,
  );

  static const Good = const AqiLevel._internal(
    PollutionLevel.good,
    'Good',
    50.0,
    51.0,
    green,
    green,
    Color(0xFF00FFFF00),
  );

  static const Moderate = const AqiLevel._internal(
    PollutionLevel.moderate,
    'Moderate',
    100.0,
    101.0,
    yellow,
    yellow,
    Color(0xFF00FFA500),
  );

  static const UnForSenGroups = const AqiLevel._internal(
    PollutionLevel.unForSenGroups,
    'Unhealthy for Sensitive Groups',
    150.0,
    151.0,
    orange,
    orange,
    Color(0xFF00FF0000),
  );
  static const Unhealthy = const AqiLevel._internal(
    PollutionLevel.unhealthy,
    'Unhealthy',
    200.0,
    201.0,
    red,
    red,
    Color(0xFF00800080),
  );

  static const VeryUnhealthy = const AqiLevel._internal(
    PollutionLevel.veryUnhealthy,
    'Very Unhealthy',
    300.0,
    301.0,
    purple,
    purple,
    Color(0xFF00800000),
  );

  static const Harzadous = const AqiLevel._internal(
    PollutionLevel.harzadous,
    'Hazardous',
    500.0,
    500.0,
    maroon,
    Color(0xFF40800080),
    maroon,
  );
}

final levels = <AqiLevel>[
  AqiLevel.Good,
  AqiLevel.Moderate,
  AqiLevel.UnForSenGroups,
  AqiLevel.Unhealthy,
  AqiLevel.VeryUnhealthy,
  AqiLevel.Harzadous,
];

AqiLevel getLevel(int index) {
  if (index < 51) {
    return AqiLevel.Good;
  } else if (index < 101) {
    return AqiLevel.Moderate;
  } else if (index < 151) {
    return AqiLevel.UnForSenGroups;
  } else if (index < 201) {
    return AqiLevel.Unhealthy;
  } else if (index < 301) {
    return AqiLevel.VeryUnhealthy;
  } else {
    return AqiLevel.Harzadous;
  }
}
