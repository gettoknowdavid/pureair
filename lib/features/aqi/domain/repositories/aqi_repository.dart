import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/aqi_by_condition.dart';
import '../entities/condition_enum.dart';

abstract class AqiRepository {
  Future<Either<Failure, AqiByCondition>> getAqiByCondition();
  Future<Either<Failure, AqiByCondition>> updateAqiByCondition(ConditionEnum condition);
}
