// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Search _$SearchFromJson(Map<String, dynamic> json) {
  return Search(
    stations: (json['stations'] as List)
        ?.map((e) =>
            e == null ? null : SearchData.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$SearchToJson(Search instance) => <String, dynamic>{
      'stations': instance.stations?.map((e) => e?.toJson())?.toList(),
    };
