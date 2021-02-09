import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../search/domain/entities/search_data.dart';

class FavouritesParams extends Equatable {
  FavouritesParams({@required this.city});
  final SearchData city;

  @override
  List<Object> get props => [city];
}
