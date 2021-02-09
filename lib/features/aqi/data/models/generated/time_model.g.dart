// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../time_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimeModel _$TimeModelFromJson(Map<String, dynamic> json) {
  return TimeModel(
    s: json['s'] as String,
    tz: json['tz'] as String,
    v: json['v'] as int,
    iso: json['iso'] as String,
  );
}

Map<String, dynamic> _$TimeModelToJson(TimeModel instance) => <String, dynamic>{
      's': instance.s,
      'tz': instance.tz,
      'v': instance.v,
      'iso': instance.iso,
    };
