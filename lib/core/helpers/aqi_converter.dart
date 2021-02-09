import 'dart:ui';

import 'package:meta/meta.dart';

import '../../features/aqi/domain/entities/aqi.dart';
import '../utils/get_colors.dart';
import '../utils/get_health_risk_message.dart';

class AqiConverter {
  AqiConverter({@required this.aqi});

  final Aqi aqi;

  Color get backgroundColor => getBackgroundColor(aqi.data.aqi);

  Color get textColor => getTextColor(aqi.data.aqi);

  String get healthRiskMessage => getHealthRiskMessage(aqi);
}
