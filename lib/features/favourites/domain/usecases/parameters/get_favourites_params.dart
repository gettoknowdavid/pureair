import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../search/domain/entities/search_data.dart';

class GetFavouritesParams extends Equatable {
  GetFavouritesParams({@required this.cities});
  final List<SearchData> cities;

  @override
  List<Object> get props => [cities];
}