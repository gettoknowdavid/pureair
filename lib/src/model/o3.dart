import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'o3.g.dart';

@JsonSerializable(explicitToJson: true)
class O3 extends Equatable {
  O3({
    this.avg,
    this.day,
    this.max,
    this.min,
  });

  final int avg;
  final DateTime day;
  final int max;
  final int min;

  @override
  List<Object> get props => [avg, day, max, min];

  static O3 fromJson(Map<String, dynamic> json) => _$O3FromJson(json);
  Map<String, dynamic> toJson() => _$O3ToJson(this);
}
