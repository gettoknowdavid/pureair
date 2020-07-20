import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pureair/src/model/aqi.dart';

part 'pureair.g.dart';

@JsonSerializable(explicitToJson: true)
class PureAir extends Equatable {
  PureAir({
    this.id,
    this.model,
    this.timeStamp,
  });

   int id;
   Aqi model;
   String timeStamp;

  @override
  List<Object> get props => [id, model, timeStamp];

  static PureAir fromJson(Map<String, dynamic> json) => _$PureAirFromJson(json);
  Map<String, dynamic> toJson() => _$PureAirToJson(this);
}
