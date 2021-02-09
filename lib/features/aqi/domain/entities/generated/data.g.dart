// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    aqi: json['aqi'] as int,
    idx: json['idx'] as int,
    attributions: (json['attributions'] as List)
        ?.map((e) =>
            e == null ? null : Attribution.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    city: json['city'] == null
        ? null
        : City.fromJson(json['city'] as Map<String, dynamic>),
    dominentpol: json['dominentpol'] as String,
    iaqi: json['iaqi'] == null
        ? null
        : Iaqi.fromJson(json['iaqi'] as Map<String, dynamic>),
    time: json['time'] == null
        ? null
        : Time.fromJson(json['time'] as Map<String, dynamic>),
    forecast: json['forecast'] == null
        ? null
        : Forecast.fromJson(json['forecast'] as Map<String, dynamic>),
    debug: json['debug'] == null
        ? null
        : Debug.fromJson(json['debug'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'aqi': instance.aqi,
      'idx': instance.idx,
      'attributions': instance.attributions?.map((e) => e?.toJson())?.toList(),
      'city': instance.city?.toJson(),
      'dominentpol': instance.dominentpol,
      'iaqi': instance.iaqi?.toJson(),
      'time': instance.time?.toJson(),
      'forecast': instance.forecast?.toJson(),
      'debug': instance.debug?.toJson(),
    };
