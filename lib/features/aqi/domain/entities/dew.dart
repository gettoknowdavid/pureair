import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'generated/dew.g.dart';

@JsonSerializable(explicitToJson: true)
class Dew extends Equatable {
  Dew({this.v});

  final double v;

  @override
  List<Object> get props => [v];

  static Dew fromJson(Map<String, dynamic> json) => _$DewFromJson(json);
  Map<String, dynamic> toJson() => _$DewToJson(this);
}
