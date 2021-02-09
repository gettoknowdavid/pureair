// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../attribution_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttributionModel _$AttributionModelFromJson(Map<String, dynamic> json) {
  return AttributionModel(
    url: json['url'] as String,
    name: json['name'] as String,
    logo: json['logo'] as String,
  );
}

Map<String, dynamic> _$AttributionModelToJson(AttributionModel instance) =>
    <String, dynamic>{
      'url': instance.url,
      'name': instance.name,
      'logo': instance.logo,
    };
