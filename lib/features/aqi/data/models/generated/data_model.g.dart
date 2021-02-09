// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataModel _$DataModelFromJson(Map<String, dynamic> json) {
  return DataModel(
    aqi: json['aqi'] as int,
    idx: json['idx'] as int,
    attributions: (json['attributions'] as List)
        ?.map((e) => e == null
            ? null
            : AttributionModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    city: json['city'] == null
        ? null
        : CityModel.fromJson(json['city'] as Map<String, dynamic>),
    dominentpol: json['dominentpol'] as String,
    iaqi: json['iaqi'] == null
        ? null
        : IaqiModel.fromJson(json['iaqi'] as Map<String, dynamic>),
    time: json['time'] == null
        ? null
        : TimeModel.fromJson(json['time'] as Map<String, dynamic>),
    forecast: json['forecast'] == null
        ? null
        : ForecastModel.fromJson(json['forecast'] as Map<String, dynamic>),
    debug: json['debug'] == null
        ? null
        : DebugModel.fromJson(json['debug'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$DataModelToJson(DataModel instance) => <String, dynamic>{
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
