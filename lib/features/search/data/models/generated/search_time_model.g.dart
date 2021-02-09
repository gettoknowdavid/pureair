// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../search_time_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchTimeModel _$SearchTimeModelFromJson(Map<String, dynamic> json) {
  return SearchTimeModel(
    tz: json['tz'] as String,
    stime: json['stime'] as String,
    vtime: json['vtime'] as int,
  );
}

Map<String, dynamic> _$SearchTimeModelToJson(SearchTimeModel instance) =>
    <String, dynamic>{
      'tz': instance.tz,
      'stime': instance.stime,
      'vtime': instance.vtime,
    };
