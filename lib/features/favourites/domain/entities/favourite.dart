import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../search/domain/entities/search_data.dart';

part 'favourite.g.dart';

@JsonSerializable(explicitToJson: true)
class Favourite extends Equatable {
  Favourite({this.cities});

  final List<SearchData> cities;

  @override
  List<Object> get props => [cities];

  static Favourite fromJson(Map<String, dynamic> json) =>
      _$FavouriteFromJson(json);
  Map<String, dynamic> toJson() => _$FavouriteToJson(this);
}
