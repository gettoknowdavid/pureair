import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'daily.dart';

part 'forecast.g.dart';

@JsonSerializable(explicitToJson: true)
class Forecast extends Equatable {
  Forecast({
    this.daily,
  });

  final Daily daily;

  @override
  List<Object> get props => [daily];

  static Forecast fromJson(Map<String, dynamic> json) =>
      _$ForecastFromJson(json);
  Map<String, dynamic> toJson() => _$ForecastToJson(this);
}
