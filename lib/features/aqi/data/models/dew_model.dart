import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/dew.dart';

part './generated/dew_model.g.dart';

@JsonSerializable(explicitToJson: true)
class DewModel extends Dew {
  DewModel({@required double v}): super(v: v);

  static DewModel fromJson(Map<String, dynamic> json) => _$DewModelFromJson(json);
   @override
  Map<String, dynamic> toJson() => _$DewModelToJson(this);
}
