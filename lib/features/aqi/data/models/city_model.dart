// The city class properties are the coordinates, the name and
// url of the city where the air monitoring station is located

import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/city.dart';

part './generated/city_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CityModel extends City {
  CityModel({
   @required List<double> geo,
   @required String name,
   @required String url,
  }):super(geo: geo, name: name, url: url);


  static CityModel fromJson(Map<String, dynamic> json) => _$CityModelFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$CityModelToJson(this);
}