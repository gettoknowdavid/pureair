// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../attribution.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Attribution _$AttributionFromJson(Map<String, dynamic> json) {
  return Attribution(
    url: json['url'] as String,
    name: json['name'] as String,
    logo: json['logo'] as String,
  );
}

Map<String, dynamic> _$AttributionToJson(Attribution instance) =>
    <String, dynamic>{
      'url': instance.url,
      'name': instance.name,
      'logo': instance.logo,
    };
