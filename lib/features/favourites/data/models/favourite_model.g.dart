// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favourite_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavouriteModel _$FavouriteModelFromJson(Map<String, dynamic> json) {
  return FavouriteModel(
    cities: (json['cities'] as List)
        ?.map((e) => e == null
            ? null
            : SearchDataModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$FavouriteModelToJson(FavouriteModel instance) =>
    <String, dynamic>{
      'cities': instance.cities?.map((e) => e?.toJson())?.toList(),
    };
