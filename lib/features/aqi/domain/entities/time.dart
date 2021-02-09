import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'generated/time.g.dart';

@JsonSerializable(explicitToJson: true)
class Time extends Equatable{
    Time({
        this.s,
        this.tz,
        this.v,
        this.iso,
    });

    final String s;
    final String tz;
    final int v;
    final String iso;

  @override
  List<Object> get props => [s, tz, v, iso];

  static Time fromJson(Map<String, dynamic> json) => _$TimeFromJson(json);
  Map<String, dynamic> toJson() => _$TimeToJson(this);

}