import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'search_station.dart';
import 'search_time.dart';

part 'generated/search_data.g.dart';

@JsonSerializable(explicitToJson: true)
class SearchData extends Equatable {
  SearchData({
    this.uid,
    this.aqi,
    this.time,
    this.station,
  });

  final int uid;
  final String aqi;
  final SearchTime time;
  final SearchStation station;

  @override
  List<Object> get props => [uid, aqi, time, station];

  static SearchData fromJson(Map<String, dynamic> json) =>
      _$SearchDataFromJson(json);
  Map<String, dynamic> toJson() => _$SearchDataToJson(this);
}
