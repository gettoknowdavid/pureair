import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/favourites_repository.dart';
import 'parameters/favourites_params.dart';

class RemoveFavouriteUseCase implements UseCase<void, FavouritesParams> {
  RemoveFavouriteUseCase({@required this.repository});
  final FavouritesRepository repository;

  @override
  Future<Either<Failure, void>> call(FavouritesParams params) async {
    return await repository.removeFavourite(params.city);
  }
}
