// Time class: the timezone of the station's city and other details

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'time.g.dart';

@JsonSerializable(explicitToJson: true)
class Time extends Equatable {
  Time({
    this.s,
    this.tz,
    this.v,
  });

  final DateTime s;
  final String tz;
  final int v;

  @override
  List<Object> get props => [s, tz, v];

  static Time fromJson(Map<String, dynamic> json) => _$TimeFromJson(json);
  Map<String, dynamic> toJson() => _$TimeToJson(this);
}