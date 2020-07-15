import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'data.dart';

part 'aqi.g.dart';

@JsonSerializable(explicitToJson: true)
class Aqi extends Equatable {
  Aqi({
    this.status,
    this.data,
  });

  final String status;
  final Data data;
  @override
  List<Object> get props => [status, data];

  static Aqi fromJson(Map<String, dynamic> json) =>
      _$AqiFromJson(json);
  Map<String, dynamic> toJson() => _$AqiToJson(this);
}
