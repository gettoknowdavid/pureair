import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../aqi/domain/entities/aqi_by_condition.dart';
import '../repositories/search_repository.dart';
import 'parameters/details_params.dart';

class GetSearchDetailsUseCase implements UseCase<AqiByCondition, DetailsParams> {
  GetSearchDetailsUseCase({@required this.repository});
  final SearchRepository repository;

  @override
  Future<Either<Failure, AqiByCondition>> call(params) async {
    return await repository.getSearchDetails(params.lat, params.lon);
  }
}
