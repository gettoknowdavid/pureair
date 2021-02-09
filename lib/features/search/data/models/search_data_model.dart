import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/search_data.dart';
import 'search_station_model.dart';
import 'search_time_model.dart';

part 'generated/search_data_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SearchDataModel extends SearchData {
  SearchDataModel({
    int uid,
    String aqi,
    SearchTimeModel time,
    SearchStationModel station,
  }) : super(uid: uid, aqi: aqi, time: time, station: station);

  @override
  List<Object> get props => [uid, aqi, time, station];

  static SearchDataModel fromJson(Map<String, dynamic> json) =>
      _$SearchDataModelFromJson(json);
  Map<String, dynamic> toJson() => _$SearchDataModelToJson(this);
}
