import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/aqi_by_condition.dart';
import '../../domain/entities/condition_enum.dart';
import 'aqi_model.dart';

part './generated/aqi_by_condition_model.g.dart';

@JsonSerializable(explicitToJson: true)
class AqiByConditionModel extends AqiByCondition {
  AqiByConditionModel({
    @required ConditionEnum condition,
    @required AqiModel aqi,
    @required String message,
    @required List<Map<String, String>> pollutants,
  }) : super(
          condition: condition,
          aqi: aqi,
          message: message,
          pollutants: pollutants,
        );

  static AqiByConditionModel fromJson(Map<String, dynamic> json) =>_$AqiByConditionModelFromJson(json);
  Map<String, dynamic> toJson() => _$AqiByConditionModelToJson(this);
}
