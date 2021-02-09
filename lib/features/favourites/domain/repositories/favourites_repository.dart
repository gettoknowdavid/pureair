import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../search/domain/entities/search_data.dart';

abstract class FavouritesRepository {
  Future<Either<Failure, List<SearchData>>> getFavourites();

  Future<Either<Failure, void>> addFavourite(SearchData city);

  Future<Either<Failure, void>> removeFavourite(SearchData city);
}
