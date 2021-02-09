import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/search_aqi.dart';
import '../repositories/search_repository.dart';
import 'parameters/search_city_params.dart';

class SearchCityUseCase implements UseCase<SearchAqi, SearchParams> {
  SearchCityUseCase({@required this.repository});
  final SearchRepository repository;

  @override
  Future<Either<Failure, SearchAqi>> call(params) async {
    return await repository.searchCity(params.city);
  }
}
