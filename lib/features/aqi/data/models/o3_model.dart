import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/o3.dart';

part './generated/o3_model.g.dart';

@JsonSerializable(explicitToJson: true)
class O3Model extends O3 {
  O3Model({
    @required int avg,
    @required String day,
    @required int max,
    @required int min,
  }) : super(avg: avg, day: day, max: max, min: min);

  static O3Model fromJson(Map<String, dynamic> json) => _$O3ModelFromJson(json);
   @override
  Map<String, dynamic> toJson() => _$O3ModelToJson(this);
}
