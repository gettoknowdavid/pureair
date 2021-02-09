import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'geo.g.dart';

@JsonSerializable(explicitToJson: true)
class Geo extends Equatable {
  Geo({this.lat, this.lon});

  final double lat;
  final double lon;

  @override
  List<Object> get props => [lat, lon];

  static Geo fromJson(Map<String, dynamic> json) => _$GeoFromJson(json);
  Map<String, dynamic> toJson() => _$GeoToJson(this);
}
