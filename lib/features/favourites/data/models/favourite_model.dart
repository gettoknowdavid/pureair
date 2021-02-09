import 'package:json_annotation/json_annotation.dart';

import '../../../search/data/models/search_data_model.dart';
import '../../domain/entities/favourite.dart';

part 'favourite_model.g.dart';

@JsonSerializable(explicitToJson: true)
class FavouriteModel extends Favourite {
  FavouriteModel({List<SearchDataModel> cities}) : super(cities: cities);

  static FavouriteModel fromJson(Map<String, dynamic> json) =>
      _$FavouriteModelFromJson(json);
  Map<String, dynamic> toJson() => _$FavouriteModelToJson(this);
}
