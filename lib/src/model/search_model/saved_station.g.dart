// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_station.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SavedStation _$SavedStationFromJson(Map<String, dynamic> json) {
  return SavedStation(
    geo: (json['geo'] as List)?.map((e) => (e as num)?.toDouble())?.toList(),
  );
}

Map<String, dynamic> _$SavedStationToJson(SavedStation instance) =>
    <String, dynamic>{
      'geo': instance.geo,
    };
