// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../aqi.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Aqi _$AqiFromJson(Map<String, dynamic> json) {
  return Aqi(
    status: json['status'] as String,
    data: json['data'] == null
        ? null
        : Data.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$AqiToJson(Aqi instance) => <String, dynamic>{
      'status': instance.status,
      'data': instance.data?.toJson(),
    };
