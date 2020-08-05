import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pureair/src/model/aqi.dart';
import 'package:pureair/src/model/search_model/geo.dart';

part 'favourites.g.dart';

@JsonSerializable(explicitToJson: true)
class Favourites extends Equatable {
  Favourites({this.geos, this.favModels});

  final List<Geo> geos;
  final List<Aqi> favModels;

  @override
  List<Object> get props => [geos, favModels];

  static Favourites fromJson(Map<String, dynamic> json) =>
      _$FavouritesFromJson(json);
  Map<String, dynamic> toJson() => _$FavouritesToJson(this);
}
