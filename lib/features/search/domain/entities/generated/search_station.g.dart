// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../search_station.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchStation _$SearchStationFromJson(Map<String, dynamic> json) {
  return SearchStation(
    name: json['name'] as String,
    geo: (json['geo'] as List)?.map((e) => (e as num)?.toDouble())?.toList(),
    url: json['url'] as String,
  );
}

Map<String, dynamic> _$SearchStationToJson(SearchStation instance) =>
    <String, dynamic>{
      'name': instance.name,
      'geo': instance.geo,
      'url': instance.url,
    };
