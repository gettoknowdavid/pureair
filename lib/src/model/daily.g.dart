// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Daily _$DailyFromJson(Map<String, dynamic> json) {
  return Daily(
    o3: (json['o3'] as List)
        ?.map((e) => e == null ? null : O3.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    pm10: (json['pm10'] as List)
        ?.map((e) => e == null ? null : O3.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    pm25: (json['pm25'] as List)
        ?.map((e) => e == null ? null : O3.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    uvi: (json['uvi'] as List)
        ?.map((e) => e == null ? null : O3.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$DailyToJson(Daily instance) => <String, dynamic>{
      'o3': instance.o3?.map((e) => e?.toJson())?.toList(),
      'pm10': instance.pm10?.map((e) => e?.toJson())?.toList(),
      'pm25': instance.pm25?.map((e) => e?.toJson())?.toList(),
      'uvi': instance.uvi?.map((e) => e?.toJson())?.toList(),
    };
