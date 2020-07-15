import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'station.g.dart';

@JsonSerializable(explicitToJson: true)
class Station extends Equatable {
  Station({
    this.name,
    this.geo,
    this.url,
    this.country,
  });

  final String name;
  final List<double> geo;
  final String url;
  final String country;

  @override
  List<Object> get props => [name, geo, url, country];

  static Station fromJson(Map<String, dynamic> json) => _$StationFromJson(json);
  Map<String, dynamic> toJson() => _$StationToJson(this);
}

