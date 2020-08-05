// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favourites.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Favourites _$FavouritesFromJson(Map<String, dynamic> json) {
  return Favourites(
    geos: (json['geos'] as List)
        ?.map((e) => e == null ? null : Geo.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    favModels: (json['favModels'] as List)
        ?.map((e) => e == null ? null : Aqi.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$FavouritesToJson(Favourites instance) =>
    <String, dynamic>{
      'geos': instance.geos?.map((e) => e?.toJson())?.toList(),
      'favModels': instance.favModels?.map((e) => e?.toJson())?.toList(),
    };
