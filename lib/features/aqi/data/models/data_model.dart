import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/data.dart';
import 'attribution_model.dart';
import 'city_model.dart';
import 'debug_model.dart';
import 'forecast_model.dart';
import 'iaqi_model.dart';
import 'time_model.dart';

part './generated/data_model.g.dart';

@JsonSerializable(explicitToJson: true)
class DataModel extends Data {
  DataModel({
    @required int aqi,
    @required int idx,
    @required List<AttributionModel> attributions,
    @required CityModel city,
    @required String dominentpol,
    @required IaqiModel iaqi,
    @required TimeModel time,
    @required ForecastModel forecast,
    @required DebugModel debug,
  }) : super(
          aqi: aqi,
          idx: idx,
          attributions: attributions,
          city: city,
          dominentpol: dominentpol,
          iaqi: iaqi,
          time: time,
          forecast: forecast,
          debug: debug,
        );

  static DataModel fromJson(Map<String, dynamic> json) => _$DataModelFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$DataModelToJson(this);
}
