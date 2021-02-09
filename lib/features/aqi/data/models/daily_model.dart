import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/daily.dart';
import 'o3_model.dart';

part './generated/daily_model.g.dart';

@JsonSerializable(explicitToJson: true)
class DailyModel extends Daily {
  DailyModel({
    @required List<O3Model> o3,
    @required List<O3Model> pm10,
    @required List<O3Model> pm25,
    @required List<O3Model> uvi,
  }) : super(o3: o3, pm10: pm10, pm25: pm25, uvi: uvi);

  static DailyModel fromJson(Map<String, dynamic> json) => _$DailyModelFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$DailyModelToJson(this);
}
