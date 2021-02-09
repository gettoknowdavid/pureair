import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../../search/domain/entities/search_data.dart';
import '../../domain/repositories/favourites_repository.dart';
import '../datasources/favourites_local_datasource.dart';

class FavouritesRepositoryImplementation implements FavouritesRepository {
  FavouritesRepositoryImplementation({
    @required this.localDataSource,
    @required this.networkInfo,
  });
  final FavouritesLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, void>> addFavourite(SearchData city) async {
    try {
      final _r = await localDataSource.addFavourite(city);
      return Right(_r);
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, List<SearchData>>> getFavourites() async {
    final _r = await localDataSource.getFavourites();
    return Right(_r);
  }

  @override
  Future<Either<Failure, void>> removeFavourite(SearchData city) async {
    try {
      final _r = await localDataSource.removeFavourite(city);
      return Right(_r);
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }
}
