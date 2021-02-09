import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/forecast.dart';
import 'daily_model.dart';

part './generated/forecast_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ForecastModel extends Forecast {
  ForecastModel({@required DailyModel daily}) : super(daily: daily);

  @override
  List<Object> get props => [daily];

  static ForecastModel fromJson(Map<String, dynamic> json) =>
      _$ForecastModelFromJson(json);
   @override
  Map<String, dynamic> toJson() => _$ForecastModelToJson(this);
}
