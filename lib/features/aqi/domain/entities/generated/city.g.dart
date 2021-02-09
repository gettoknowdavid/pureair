// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../city.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

City _$CityFromJson(Map<String, dynamic> json) {
  return City(
    geo: (json['geo'] as List)?.map((e) => (e as num)?.toDouble())?.toList(),
    name: json['name'] as String,
    url: json['url'] as String,
  );
}

Map<String, dynamic> _$CityToJson(City instance) => <String, dynamic>{
      'geo': instance.geo,
      'name': instance.name,
      'url': instance.url,
    };
