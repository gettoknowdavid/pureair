import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pureair/src/model/aqi.dart';

part 'pureair.g.dart';

@JsonSerializable(explicitToJson: true)
class PureAir extends Equatable {
  PureAir({
    this.model,
    this.timeStamp,
  });

  final Aqi model;
  final String timeStamp;

  @override
  List<Object> get props => [model, timeStamp];

  static PureAir fromJson(Map<String, dynamic> json) => _$PureAirFromJson(json);
  Map<String, dynamic> toJson() => _$PureAirToJson(this);
}
