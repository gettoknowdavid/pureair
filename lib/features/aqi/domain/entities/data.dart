import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'attribution.dart';
import 'city.dart';
import 'debug.dart';
import 'forecast.dart';
import 'iaqi.dart';
import 'time.dart';

part 'generated/data.g.dart';

@JsonSerializable(explicitToJson: true)
class Data extends Equatable {
  Data({
    this.aqi,
    this.idx,
    this.attributions,
    this.city,
    this.dominentpol,
    this.iaqi,
    this.time,
    this.forecast,
    this.debug,
  });

  final int aqi;
  final int idx;
  final List<Attribution> attributions;
  final City city;
  final String dominentpol;
  final Iaqi iaqi;
  final Time time;
  final Forecast forecast;
  final Debug debug;

  @override
  List<Object> get props =>
      [aqi, idx, attributions, city, dominentpol, iaqi, time, forecast, debug];

  static Data fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
  Map<String, dynamic> toJson() => _$DataToJson(this);
}
