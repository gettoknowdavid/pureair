import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'generated/debug.g.dart';

@JsonSerializable(explicitToJson: true)
class Debug extends Equatable {
  Debug({this.sync});

  final String sync;

  @override
  List<Object> get props => [sync];

  static Debug fromJson(Map<String, dynamic> json) => _$DebugFromJson(json);
  Map<String, dynamic> toJson() => _$DebugToJson(this);
}
