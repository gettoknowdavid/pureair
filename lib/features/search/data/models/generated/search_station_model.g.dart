// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../search_station_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchStationModel _$SearchStationModelFromJson(Map<String, dynamic> json) {
  return SearchStationModel(
    name: json['name'] as String,
    geo: (json['geo'] as List)?.map((e) => (e as num)?.toDouble())?.toList(),
    url: json['url'] as String,
  );
}

Map<String, dynamic> _$SearchStationModelToJson(SearchStationModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'geo': instance.geo,
      'url': instance.url,
    };
