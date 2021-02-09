import 'dart:ui';

import 'package:meta/meta.dart';

import '../../features/aqi/domain/entities/aqi.dart';
import '../../features/aqi/domain/entities/condition_enum.dart';
import '../utils/get_colors.dart';
import '../utils/get_health_risk_message.dart';
import '../utils/get_pollutants.dart';
import '../utils/get_tailored_message.dart';

class ConditionConverter {
  ConditionConverter({@required this.aqi, @required this.condition});

  final Aqi aqi;
  final ConditionEnum condition;

  Color get backgroundColor => getBackgroundColor(aqi.data.aqi);

  Color get textColor => getTextColor(aqi.data.aqi);

  String get healthRiskMessage => getHealthRiskMessage(aqi);

  List<Map<String, String>> get pollutants => getPollutants(aqi, condition);

  String get tailoredMessage => getTailoredMessage(aqi, condition);
}
