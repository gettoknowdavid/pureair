import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/geo.dart';

part 'geo_model.g.dart';

@JsonSerializable(explicitToJson: true)
class GeoModel extends Geo {
  GeoModel({double lat, double lon}): super(lat:lat, lon:lon);


  static GeoModel fromJson(Map<String, dynamic> json) => _$GeoModelFromJson(json);
  Map<String, dynamic> toJson() => _$GeoModelToJson(this);
}
