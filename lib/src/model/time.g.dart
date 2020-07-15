// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Time _$TimeFromJson(Map<String, dynamic> json) {
  return Time(
    s: json['s'] == null ? null : DateTime.parse(json['s'] as String),
    tz: json['tz'] as String,
    v: json['v'] as int,
  );
}

Map<String, dynamic> _$TimeToJson(Time instance) => <String, dynamic>{
      's': instance.s?.toIso8601String(),
      'tz': instance.tz,
      'v': instance.v,
    };
