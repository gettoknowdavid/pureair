import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pureair/src/model/aqi.dart';
import 'package:pureair/src/model/search_model/geo.dart';

part 'favourite.g.dart';

@JsonSerializable(explicitToJson: true)
class Favourite extends Equatable {
  Favourite({ this.geo, this.favModel});

  final Geo geo;
  final Aqi favModel;

  @override
  List<Object> get props => [geo, favModel];

  static Favourite fromJson(Map<String, dynamic> json) =>
      _$FavouriteFromJson(json);
  Map<String, dynamic> toJson() => _$FavouriteToJson(this);
}
