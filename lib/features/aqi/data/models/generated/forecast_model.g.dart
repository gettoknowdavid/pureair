// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../forecast_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForecastModel _$ForecastModelFromJson(Map<String, dynamic> json) {
  return ForecastModel(
    daily: json['daily'] == null
        ? null
        : DailyModel.fromJson(json['daily'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ForecastModelToJson(ForecastModel instance) =>
    <String, dynamic>{
      'daily': instance.daily?.toJson(),
    };
