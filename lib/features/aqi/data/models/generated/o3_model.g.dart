// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../o3_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

O3Model _$O3ModelFromJson(Map<String, dynamic> json) {
  return O3Model(
    avg: json['avg'] as int,
    day: json['day'] as String,
    max: json['max'] as int,
    min: json['min'] as int,
  );
}

Map<String, dynamic> _$O3ModelToJson(O3Model instance) => <String, dynamic>{
      'avg': instance.avg,
      'day': instance.day,
      'max': instance.max,
      'min': instance.min,
    };
