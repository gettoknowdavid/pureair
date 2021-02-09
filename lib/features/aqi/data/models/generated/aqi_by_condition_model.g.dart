// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../aqi_by_condition_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AqiByConditionModel _$AqiByConditionModelFromJson(Map<String, dynamic> json) {
  return AqiByConditionModel(
    condition: _$enumDecodeNullable(_$ConditionEnumEnumMap, json['condition']),
    aqi: json['aqi'] == null
        ? null
        : AqiModel.fromJson(json['aqi'] as Map<String, dynamic>),
    message: json['message'] as String,
    pollutants: (json['pollutants'] as List)
        ?.map((e) => (e as Map<String, dynamic>)?.map(
              (k, e) => MapEntry(k, e as String),
            ))
        ?.toList(),
  );
}

Map<String, dynamic> _$AqiByConditionModelToJson(
        AqiByConditionModel instance) =>
    <String, dynamic>{
      'condition': _$ConditionEnumEnumMap[instance.condition],
      'aqi': instance.aqi?.toJson(),
      'message': instance.message,
      'pollutants': instance.pollutants,
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$ConditionEnumEnumMap = {
  ConditionEnum.none: 'none',
  ConditionEnum.asthma: 'asthma',
  ConditionEnum.bronchitis: 'bronchitis',
  ConditionEnum.lungCancer: 'lungCancer',
  ConditionEnum.emphysema: 'emphysema',
  ConditionEnum.hbp: 'hbp',
};
