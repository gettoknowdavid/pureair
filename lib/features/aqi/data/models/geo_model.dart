import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/geo.dart';

part './generated/geo_model.g.dart';

@JsonSerializable(explicitToJson: true)
class GeoModel extends Geo {
  GeoModel({@required double lat, @required double lon})
      : super(lat: lat, lon: lon);

  @override
  List<Object> get props => [lat, lon];

  static GeoModel fromJson(Map<String, dynamic> json) => _$GeoModelFromJson(json);
   @override
  Map<String, dynamic> toJson() => _$GeoModelToJson(this);
}
