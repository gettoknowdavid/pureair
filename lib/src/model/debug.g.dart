// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'debug.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Debug _$DebugFromJson(Map<String, dynamic> json) {
  return Debug(
    sync: json['sync'] == null ? null : DateTime.parse(json['sync'] as String),
  );
}

Map<String, dynamic> _$DebugToJson(Debug instance) => <String, dynamic>{
      'sync': instance.sync?.toIso8601String(),
    };