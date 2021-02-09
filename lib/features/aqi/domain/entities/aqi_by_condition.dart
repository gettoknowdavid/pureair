import 'package:equatable/equatable.dart';

import 'aqi.dart';
import 'condition_enum.dart';

class AqiByCondition extends Equatable {
  AqiByCondition({
    this.condition,
    this.aqi,
    this.message,
    this.pollutants,
  });

  final ConditionEnum condition;
  final Aqi aqi;
  final String message;
  final List<Map<String, String>> pollutants;

  @override
  List<Object> get props => [condition, aqi, message, pollutants];
}
