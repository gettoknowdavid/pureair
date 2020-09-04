// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favourite.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Favourite _$FavouriteFromJson(Map<String, dynamic> json) {
  return Favourite(
    geo: json['geo'] == null
        ? null
        : Geo.fromJson(json['geo'] as Map<String, dynamic>),
    favModel: json['favModel'] == null
        ? null
        : Aqi.fromJson(json['favModel'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$FavouriteToJson(Favourite instance) => <String, dynamic>{
      'geo': instance.geo?.toJson(),
      'favModel': instance.favModel?.toJson(),
    };
