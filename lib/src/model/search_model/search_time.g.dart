// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_time.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchTime _$SearchTimeFromJson(Map<String, dynamic> json) {
  return SearchTime(
    tz: json['tz'] as String,
    stime:
        json['stime'] == null ? null : DateTime.parse(json['stime'] as String),
    vtime: json['vtime'] as int,
  );
}

Map<String, dynamic> _$SearchTimeToJson(SearchTime instance) =>
    <String, dynamic>{
      'tz': instance.tz,
      'stime': instance.stime?.toIso8601String(),
      'vtime': instance.vtime,
    };
