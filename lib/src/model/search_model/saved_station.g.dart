// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_station.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SavedStation _$SavedStationFromJson(Map<String, dynamic> json) {
  return SavedStation(
    id: json['id'] as String,
    geo: (json['geo'] as List)?.map((e) => (e as num)?.toDouble())?.toList(),
  );
}

Map<String, dynamic> _$SavedStationToJson(SavedStation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'geo': instance.geo,
    };
