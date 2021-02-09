import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/aqi.dart';
import 'data_model.dart';

part './generated/aqi_model.g.dart';

@JsonSerializable(explicitToJson: true)
class AqiModel extends Aqi {
  AqiModel({
    @required String status,
    @required DataModel data,
  }) : super(status: status, data: data);

  static Aqi fromJson(Map<String, dynamic> json) => _$AqiModelFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$AqiModelToJson(this);
}
