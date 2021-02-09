import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'generated/search_station.g.dart';

@JsonSerializable(explicitToJson: true)
class SearchStation extends Equatable {
  SearchStation({
    this.name,
    this.geo,
    this.url,
  });

  final String name;
  final List<double> geo;
  final String url;

  @override
  List<Object> get props => [name, geo, url];

  static SearchStation fromJson(Map<String, dynamic> json) =>_$SearchStationFromJson(json);
  Map<String, dynamic> toJson() => _$SearchStationToJson(this);
}
