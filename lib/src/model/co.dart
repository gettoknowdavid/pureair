import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'co.g.dart';

@JsonSerializable(explicitToJson: true)
class Co extends Equatable {
  Co({
    this.v,
  });

  final double v;

  @override
  List<Object> get props => [v];

  static Co fromJson(Map<String, dynamic> json) => _$CoFromJson(json);
  Map<String, dynamic> toJson() => _$CoToJson(this);
}
