// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../city_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CityModel _$CityModelFromJson(Map<String, dynamic> json) {
  return CityModel(
    geo: (json['geo'] as List)?.map((e) => (e as num)?.toDouble())?.toList(),
    name: json['name'] as String,
    url: json['url'] as String,
  );
}

Map<String, dynamic> _$CityModelToJson(CityModel instance) => <String, dynamic>{
      'geo': instance.geo,
      'name': instance.name,
      'url': instance.url,
    };
