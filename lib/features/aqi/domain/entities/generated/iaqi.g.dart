// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../iaqi.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Iaqi _$IaqiFromJson(Map<String, dynamic> json) {
  return Iaqi(
    dew: json['dew'] == null
        ? null
        : Dew.fromJson(json['dew'] as Map<String, dynamic>),
    h: json['h'] == null
        ? null
        : Dew.fromJson(json['h'] as Map<String, dynamic>),
    co: json['co'] == null
        ? null
        : Dew.fromJson(json['co'] as Map<String, dynamic>),
    no2: json['no2'] == null
        ? null
        : Dew.fromJson(json['no2'] as Map<String, dynamic>),
    o3: json['o3'] == null
        ? null
        : Dew.fromJson(json['o3'] as Map<String, dynamic>),
    so2: json['so2'] == null
        ? null
        : Dew.fromJson(json['so2'] as Map<String, dynamic>),
    p: json['p'] == null
        ? null
        : Dew.fromJson(json['p'] as Map<String, dynamic>),
    pm10: json['pm10'] == null
        ? null
        : Dew.fromJson(json['pm10'] as Map<String, dynamic>),
    pm25: json['pm25'] == null
        ? null
        : Dew.fromJson(json['pm25'] as Map<String, dynamic>),
    t: json['t'] == null
        ? null
        : Dew.fromJson(json['t'] as Map<String, dynamic>),
    w: json['w'] == null
        ? null
        : Dew.fromJson(json['w'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$IaqiToJson(Iaqi instance) => <String, dynamic>{
      'dew': instance.dew?.toJson(),
      'h': instance.h?.toJson(),
      'co': instance.co?.toJson(),
      'no2': instance.no2?.toJson(),
      'o3': instance.o3?.toJson(),
      'so2': instance.so2?.toJson(),
      'p': instance.p?.toJson(),
      'pm10': instance.pm10?.toJson(),
      'pm25': instance.pm25?.toJson(),
      't': instance.t?.toJson(),
      'w': instance.w?.toJson(),
    };
