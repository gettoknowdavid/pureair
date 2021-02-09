import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/time.dart';

part './generated/time_model.g.dart';

@JsonSerializable(explicitToJson: true)
class TimeModel extends Time {
  TimeModel({
    @required String s,
    @required String tz,
    @required int v,
    @required String iso,
  }) : super(s: s, tz: tz, v: v, iso: iso);

  static TimeModel fromJson(Map<String, dynamic> json) =>
      _$TimeModelFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$TimeModelToJson(this);
}
