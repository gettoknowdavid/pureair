// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'iaqi.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Iaqi _$IaqiFromJson(Map<String, dynamic> json) {
  return Iaqi(
    co: json['co'] == null
        ? null
        : Co.fromJson(json['co'] as Map<String, dynamic>),
    h: json['h'] == null
        ? null
        : Co.fromJson(json['h'] as Map<String, dynamic>),
    no2: json['no2'] == null
        ? null
        : Co.fromJson(json['no2'] as Map<String, dynamic>),
    o3: json['o3'] == null
        ? null
        : Co.fromJson(json['o3'] as Map<String, dynamic>),
    p: json['p'] == null
        ? null
        : Co.fromJson(json['p'] as Map<String, dynamic>),
    pm10: json['pm10'] == null
        ? null
        : Co.fromJson(json['pm10'] as Map<String, dynamic>),
    pm25: json['pm25'] == null
        ? null
        : Co.fromJson(json['pm25'] as Map<String, dynamic>),
    so2: json['so2'] == null
        ? null
        : Co.fromJson(json['so2'] as Map<String, dynamic>),
    t: json['t'] == null
        ? null
        : Co.fromJson(json['t'] as Map<String, dynamic>),
    w: json['w'] == null
        ? null
        : Co.fromJson(json['w'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$IaqiToJson(Iaqi instance) => <String, dynamic>{
      'co': instance.co?.toJson(),
      'h': instance.h?.toJson(),
      'no2': instance.no2?.toJson(),
      'o3': instance.o3?.toJson(),
      'p': instance.p?.toJson(),
      'pm10': instance.pm10?.toJson(),
      'pm25': instance.pm25?.toJson(),
      'so2': instance.so2?.toJson(),
      't': instance.t?.toJson(),
      'w': instance.w?.toJson(),
    };
