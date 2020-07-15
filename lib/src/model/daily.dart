import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'o3.dart';

part 'daily.g.dart';

@JsonSerializable(explicitToJson: true)
class Daily extends Equatable {
  Daily({
    this.o3,
    this.pm10,
    this.pm25,
    this.uvi,
  });

  final List<O3> o3;
  final List<O3> pm10;
  final List<O3> pm25;
  final List<O3> uvi;

  @override
  List<Object> get props => [o3, pm10, pm25, uvi];

  static Daily fromJson(Map<String, dynamic> json) => _$DailyFromJson(json);
  Map<String, dynamic> toJson() => _$DailyToJson(this);
}
