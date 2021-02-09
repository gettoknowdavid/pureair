import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/debug.dart';

part './generated/debug_model.g.dart';

@JsonSerializable(explicitToJson: true)
class DebugModel extends Debug {
  DebugModel({@required String sync}):super(sync: sync);

  static DebugModel fromJson(Map<String, dynamic> json) => _$DebugModelFromJson(json);
   @override
  Map<String, dynamic> toJson() => _$DebugModelToJson(this);
}
