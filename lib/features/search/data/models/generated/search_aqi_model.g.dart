// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../search_aqi_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchAqiModel _$SearchAqiModelFromJson(Map<String, dynamic> json) {
  return SearchAqiModel(
    status: json['status'] as String,
    data: (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : SearchDataModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$SearchAqiModelToJson(SearchAqiModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data?.map((e) => e?.toJson())?.toList(),
    };
