import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pureair/src/model/search_model/search_time.dart';
import 'package:pureair/src/model/search_model/station.dart';

part 'search_data.g.dart';

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
  final Station station;

  @override
  List<Object> get props => [uid, aqi, time, station];

  static SearchData fromJson(Map<String, dynamic> json) =>
      _$SearchDataFromJson(json);
  Map<String, dynamic> toJson() => _$SearchDataToJson(this);
}
