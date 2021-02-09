import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/search_station.dart';

part 'generated/search_station_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SearchStationModel extends SearchStation {
  SearchStationModel({
    String name,
    List<double> geo,
    String url,
  }) : super(name: name, geo: geo, url: url);

  static SearchStationModel fromJson(Map<String, dynamic> json) =>
      _$SearchStationModelFromJson(json);
  Map<String, dynamic> toJson() => _$SearchStationModelToJson(this);

}
