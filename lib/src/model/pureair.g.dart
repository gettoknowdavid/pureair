// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pureair.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PureAir _$PureAirFromJson(Map<String, dynamic> json) {
  return PureAir(
    id: json['id'] as int,
    model: json['model'] == null
        ? null
        : Aqi.fromJson(json['model'] as Map<String, dynamic>),
    timeStamp: json['timeStamp'] as String,
  );
}

Map<String, dynamic> _$PureAirToJson(PureAir instance) => <String, dynamic>{
      'id': instance.id,
      'model': instance.model?.toJson(),
      'timeStamp': instance.timeStamp,
    };
