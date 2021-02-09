import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/no_params.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../search/domain/entities/search_data.dart';
import '../repositories/favourites_repository.dart';

class GetFavouritesUseCase implements UseCase<List<SearchData>, NoParams> {
  GetFavouritesUseCase({@required this.repository});
  final FavouritesRepository repository;

  @override
  Future<Either<Failure, List<SearchData>>> call(NoParams params) async {
    return await repository.getFavourites();
  }
}
