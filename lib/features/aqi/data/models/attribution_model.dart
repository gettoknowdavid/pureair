// The Attributions class containing the url and name
// of the AQI station

import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/attribution.dart';

part './generated/attribution_model.g.dart';

@JsonSerializable(explicitToJson: true)
class AttributionModel extends Attribution {
  AttributionModel({
   @required String url,
   @required String name,
   @required String logo,
  }):super(url: url, name: name, logo: logo);

  static AttributionModel fromJson(Map<String, dynamic> json) =>
      _$AttributionModelFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$AttributionModelToJson(this);
}
