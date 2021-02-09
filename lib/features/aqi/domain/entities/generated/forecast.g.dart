// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../forecast.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Forecast _$ForecastFromJson(Map<String, dynamic> json) {
  return Forecast(
    daily: json['daily'] == null
        ? null
        : Daily.fromJson(json['daily'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ForecastToJson(Forecast instance) => <String, dynamic>{
      'daily': instance.daily?.toJson(),
    };
