import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'city.g.dart';

@JsonSerializable(explicitToJson: true)
class City extends Equatable {
  City({
    this.geo,
    this.name,
    this.url,
  });

  final List<double> geo;
  final String name;
  final String url;

  @override
  List<Object> get props => [geo, name, url];

  static City fromJson(Map<String, dynamic> json) => _$CityFromJson(json);
  Map<String, dynamic> toJson() => _$CityToJson(this);
}
