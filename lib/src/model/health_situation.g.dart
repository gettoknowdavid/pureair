// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'health_situation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HealthSituation _$HealthSituationFromJson(Map<String, dynamic> json) {
  return HealthSituation(
    situation: _$enumDecodeNullable(_$SituationEnumEnumMap, json['situation']),
    model: json['model'] == null
        ? null
        : Aqi.fromJson(json['model'] as Map<String, dynamic>),
    message: json['message'] as String,
    pollutants: (json['pollutants'] as List)
        ?.map((e) => (e as Map<String, dynamic>)?.map(
              (k, e) => MapEntry(k, e as String),
            ))
        ?.toList(),
  );
}

Map<String, dynamic> _$HealthSituationToJson(HealthSituation instance) =>
    <String, dynamic>{
      'situation': _$SituationEnumEnumMap[instance.situation],
      'model': instance.model?.toJson(),
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

const _$SituationEnumEnumMap = {
  SituationEnum.none: 'none',
  SituationEnum.asthma: 'asthma',
  SituationEnum.bronchitis: 'bronchitis',
  SituationEnum.lungCancer: 'lungCancer',
  SituationEnum.emphysema: 'emphysema',
  SituationEnum.hbp: 'hbp',
};
