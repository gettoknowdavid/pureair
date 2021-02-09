import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import '../models/aqi_by_condition_model.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/helpers/condition_converter.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/aqi_by_condition.dart';
import '../../domain/entities/condition_enum.dart';
import '../../domain/repositories/aqi_repository.dart';
import '../data_sources/aqi_local_data_source.dart';
import '../data_sources/aqi_remote_data_source.dart';

class AqiRepositoryImplementation implements AqiRepository {
  AqiRepositoryImplementation({
    @required this.remoteDataSource,
    @required this.localDataSource,
    @required this.networkInfo,
  });

  final AqiRemoteDataSource remoteDataSource;
  final AqiLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, AqiByCondition>> getAqiByCondition() async {
    if (await networkInfo.isConnected) {
      final _localAqi = await localDataSource.getLastAqi();
      final _condition =
          _localAqi == null ? ConditionEnum.none : _localAqi.condition;

      try {
        final _aqi = await remoteDataSource.getAqi();

        final converter = ConditionConverter(
          aqi: _aqi,
          condition: _condition,
        );

        final _result = AqiByConditionModel(
          condition: converter.condition,
          aqi: converter.aqi,
          message: converter.tailoredMessage,
          pollutants: converter.pollutants,
        );

        await localDataSource.storeAqi(_result);

        return Right(_result);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        AqiByCondition _localAqi = await localDataSource.getLastAqi();

        return Right(_localAqi);
      } on DatabaseException {
        return Left(DatabaseFailure());
      }
    }
  }

  @override
  Future<Either<Failure, AqiByCondition>> updateAqiByCondition(
      ConditionEnum condition) async {
    if (await networkInfo.isConnected) {
      try {
        final _aqi = await remoteDataSource.getAqi();

        final converter = ConditionConverter(aqi: _aqi, condition: condition);

        final _result = AqiByConditionModel(
          condition: condition,
          aqi: converter.aqi,
          message: converter.tailoredMessage,
          pollutants: converter.pollutants,
        );

        await localDataSource.storeAqi(_result);

        return Right(_result);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        AqiByCondition _localAqi = await localDataSource.getLastAqi();

        final _result = AqiByConditionModel(
          condition: condition,
          aqi: _localAqi.aqi,
          message: _localAqi.message,
          pollutants: _localAqi.pollutants,
        );

        await localDataSource.storeAqi(_result);

        return Right(_result);
      } on DatabaseException {
        return Left(DatabaseFailure());
      }
    }
  }
}
