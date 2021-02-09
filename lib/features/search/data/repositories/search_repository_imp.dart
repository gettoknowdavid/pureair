import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/helpers/condition_converter.dart';
import '../../../../core/network/network_info.dart';
import '../../../aqi/data/data_sources/aqi_local_data_source.dart';
import '../../../aqi/data/models/aqi_by_condition_model.dart';
import '../../../aqi/domain/entities/aqi_by_condition.dart';
import '../../../aqi/domain/entities/condition_enum.dart';
import '../../domain/entities/search_aqi.dart';
import '../../domain/repositories/search_repository.dart';
import '../datasources/search_remote_data_source.dart';

class SearchRepositoryImplementation implements SearchRepository {
  SearchRepositoryImplementation({
    @required this.remoteDataSource,
    @required this.aqiLocalDataSource,
    @required this.networkInfo,
  });
  final AqiLocalDataSource aqiLocalDataSource;
  final SearchRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, AqiByCondition>> getSearchDetails(double lat, double lon) async {
    if (await networkInfo.isConnected) {
      try {
        final _localAqi = await aqiLocalDataSource.getLastAqi();
        final _condition = _localAqi == null ? ConditionEnum.none : _localAqi.condition;

        final _aqi = await remoteDataSource.getSearchDetails(lat, lon);

        final converter = ConditionConverter(aqi: _aqi, condition: _condition);

        final _result = AqiByConditionModel(
          condition: converter.condition,
          aqi: converter.aqi,
          message: converter.tailoredMessage,
          pollutants: converter.pollutants,
        );

        return Right(_result);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, SearchAqi>> searchCity(String city) async {
    if (await networkInfo.isConnected) {
      try {
        final _result = await remoteDataSource.searchCity(city);

        return Right(_result);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }
}
