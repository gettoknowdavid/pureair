import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/favourites_repository.dart';
import 'parameters/favourites_params.dart';

class AddFavouriteUseCase implements UseCase<void, FavouritesParams> {
  AddFavouriteUseCase({@required this.repository});
  final FavouritesRepository repository;

  @override
  Future<Either<Failure, void>> call(FavouritesParams params) async {
    return await repository.addFavourite(params.city);
  }
}
