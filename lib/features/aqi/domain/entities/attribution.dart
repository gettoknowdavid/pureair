import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'generated/attribution.g.dart';

@JsonSerializable(explicitToJson: true)
class Attribution extends Equatable {
  Attribution({
    this.url,
    this.name,
    this.logo,
  });

  final String url;
  final String name;
  final String logo;

  @override
  List<Object> get props => [url, name, logo];

  static Attribution fromJson(Map<String, dynamic> json) => _$AttributionFromJson(json);
  Map<String, dynamic> toJson() => _$AttributionToJson(this);
}
