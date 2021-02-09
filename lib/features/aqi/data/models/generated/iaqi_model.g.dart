// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../iaqi_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IaqiModel _$IaqiModelFromJson(Map<String, dynamic> json) {
  return IaqiModel(
    dew: json['dew'] == null
        ? null
        : DewModel.fromJson(json['dew'] as Map<String, dynamic>),
    h: json['h'] == null
        ? null
        : DewModel.fromJson(json['h'] as Map<String, dynamic>),
    co: json['co'] == null
        ? null
        : DewModel.fromJson(json['co'] as Map<String, dynamic>),
    no2: json['no2'] == null
        ? null
        : DewModel.fromJson(json['no2'] as Map<String, dynamic>),
    o3: json['o3'] == null
        ? null
        : DewModel.fromJson(json['o3'] as Map<String, dynamic>),
    so2: json['so2'] == null
        ? null
        : DewModel.fromJson(json['so2'] as Map<String, dynamic>),
    p: json['p'] == null
        ? null
        : DewModel.fromJson(json['p'] as Map<String, dynamic>),
    pm10: json['pm10'] == null
        ? null
        : DewModel.fromJson(json['pm10'] as Map<String, dynamic>),
    pm25: json['pm25'] == null
        ? null
        : DewModel.fromJson(json['pm25'] as Map<String, dynamic>),
    t: json['t'] == null
        ? null
        : DewModel.fromJson(json['t'] as Map<String, dynamic>),
    w: json['w'] == null
        ? null
        : DewModel.fromJson(json['w'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$IaqiModelToJson(IaqiModel instance) => <String, dynamic>{
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
