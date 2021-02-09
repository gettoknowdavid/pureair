import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/aqi_by_condition.dart';
import '../repositories/aqi_repository.dart';
import 'params/condition_params.dart';

class UpdateAqiByConditionUseCase
    implements UseCase<AqiByCondition, ConditionParams> {
  UpdateAqiByConditionUseCase({@required this.repository});

  final AqiRepository repository;

  @override
  Future<Either<Failure, AqiByCondition>> call(ConditionParams params) async {
    return await repository.updateAqiByCondition(params.condition);
  }
}
