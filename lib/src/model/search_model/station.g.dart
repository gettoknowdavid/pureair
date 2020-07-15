// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'station.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Station _$StationFromJson(Map<String, dynamic> json) {
  return Station(
    name: json['name'] as String,
    geo: (json['geo'] as List)?.map((e) => (e as num)?.toDouble())?.toList(),
    url: json['url'] as String,
    country: json['country'] as String,
  );
}

Map<String, dynamic> _$StationToJson(Station instance) => <String, dynamic>{
      'name': instance.name,
      'geo': instance.geo,
      'url': instance.url,
      'country': instance.country,
    };
