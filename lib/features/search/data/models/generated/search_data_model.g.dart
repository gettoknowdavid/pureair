// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../search_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchDataModel _$SearchDataModelFromJson(Map<String, dynamic> json) {
  return SearchDataModel(
    uid: json['uid'] as int,
    aqi: json['aqi'] as String,
    time: json['time'] == null
        ? null
        : SearchTimeModel.fromJson(json['time'] as Map<String, dynamic>),
    station: json['station'] == null
        ? null
        : SearchStationModel.fromJson(json['station'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$SearchDataModelToJson(SearchDataModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'aqi': instance.aqi,
      'time': instance.time?.toJson(),
      'station': instance.station?.toJson(),
    };
