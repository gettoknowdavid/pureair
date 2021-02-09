// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../search_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchData _$SearchDataFromJson(Map<String, dynamic> json) {
  return SearchData(
    uid: json['uid'] as int,
    aqi: json['aqi'] as String,
    time: json['time'] == null
        ? null
        : SearchTime.fromJson(json['time'] as Map<String, dynamic>),
    station: json['station'] == null
        ? null
        : SearchStation.fromJson(json['station'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$SearchDataToJson(SearchData instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'aqi': instance.aqi,
      'time': instance.time?.toJson(),
      'station': instance.station?.toJson(),
    };
