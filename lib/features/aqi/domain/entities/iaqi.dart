import 'package:equatable/equatable.dart';
import 'dew.dart';
import 'package:json_annotation/json_annotation.dart';

part 'generated/iaqi.g.dart';

@JsonSerializable(explicitToJson: true)
class Iaqi extends Equatable {
  Iaqi({
    this.dew,
    this.h,
    this.co,
    this.no2,
    this.o3,
    this.so2,
    this.p,
    this.pm10,
    this.pm25,
    this.t,
    this.w,
  });

  final Dew dew;
  final Dew h;
  final Dew co;
  final Dew no2;
  final Dew o3;
  final Dew so2;
  final Dew p;
  final Dew pm10;
  final Dew pm25;
  final Dew t;
  final Dew w;

  @override
  List<Object> get props => [dew, h, co, no2, o3, so2, p, pm10, pm25, t, w];

  static Iaqi fromJson(Map<String, dynamic> json) => _$IaqiFromJson(json);
  Map<String, dynamic> toJson() => _$IaqiToJson(this);
}
