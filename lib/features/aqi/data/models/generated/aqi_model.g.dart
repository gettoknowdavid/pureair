// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../aqi_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AqiModel _$AqiModelFromJson(Map<String, dynamic> json) {
  return AqiModel(
    status: json['status'] as String,
    data: json['data'] == null
        ? null
        : DataModel.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$AqiModelToJson(AqiModel instance) => <String, dynamic>{
      'status': instance.status,
      'data': instance.data?.toJson(),
    };
