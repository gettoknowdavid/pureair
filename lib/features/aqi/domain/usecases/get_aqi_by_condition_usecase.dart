import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/no_params.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/aqi_by_condition.dart';
import '../repositories/aqi_repository.dart';

class GetAqiByConditionUseCase
    implements UseCase<AqiByCondition, NoParams> {
  GetAqiByConditionUseCase({@required this.repository});

  final AqiRepository repository;

  @override
  Future<Either<Failure, AqiByCondition>> call(NoParams params) async {
    return await repository.getAqiByCondition();
  }
}
