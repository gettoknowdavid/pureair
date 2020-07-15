// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_aqi.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchAqi _$SearchAqiFromJson(Map<String, dynamic> json) {
  return SearchAqi(
    status: json['status'] as String,
    data: (json['data'] as List)
        ?.map((e) =>
            e == null ? null : SearchData.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$SearchAqiToJson(SearchAqi instance) => <String, dynamic>{
      'status': instance.status,
      'data': instance.data?.map((e) => e?.toJson())?.toList(),
    };
