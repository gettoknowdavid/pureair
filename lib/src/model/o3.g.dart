// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'o3.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

O3 _$O3FromJson(Map<String, dynamic> json) {
  return O3(
    avg: json['avg'] as int,
    day: json['day'] == null ? null : DateTime.parse(json['day'] as String),
    max: json['max'] as int,
    min: json['min'] as int,
  );
}

Map<String, dynamic> _$O3ToJson(O3 instance) => <String, dynamic>{
      'avg': instance.avg,
      'day': instance.day?.toIso8601String(),
      'max': instance.max,
      'min': instance.min,
    };
