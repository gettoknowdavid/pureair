import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'co.dart';

part 'iaqi.g.dart';

@JsonSerializable(explicitToJson: true)
class Iaqi extends Equatable {
  Iaqi({
    this.co,
    this.h,
    this.no2,
    this.o3,
    this.p,
    this.pm10,
    this.pm25,
    this.so2,
    this.t,
    this.w,
  });

  final Co co;
  final Co h;
  final Co no2;
  final Co o3;
  final Co p;
  final Co pm10;
  final Co pm25;
  final Co so2;
  final Co t;
  final Co w;

  @override
  List<Object> get props => [co, h, no2, o3, p, pm10, pm25, so2, t, w];

  static Iaqi fromJson(Map<String, dynamic> json) => _$IaqiFromJson(json);
  Map<String, dynamic> toJson() => _$IaqiToJson(this);
}
