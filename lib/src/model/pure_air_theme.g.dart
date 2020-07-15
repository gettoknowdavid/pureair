// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pure_air_theme.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PureAirTheme _$PureAirThemeFromJson(Map<String, dynamic> json) {
  return PureAirTheme(
    _$enumDecodeNullable(_$ThemeEnumEnumMap, json['theme']),
  );
}

Map<String, dynamic> _$PureAirThemeToJson(PureAirTheme instance) =>
    <String, dynamic>{
      'theme': _$ThemeEnumEnumMap[instance.theme],
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

const _$ThemeEnumEnumMap = {
  ThemeEnum.lightTheme: 'lightTheme',
  ThemeEnum.darkTheme: 'darkTheme',
};
