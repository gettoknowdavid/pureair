import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../aqi/domain/entities/aqi_by_condition.dart';
import '../entities/search_aqi.dart';

abstract class SearchRepository {
  Future<Either<Failure, SearchAqi>> searchCity(String city);

  Future<Either<Failure, AqiByCondition>> getSearchDetails(double lat, double lon);
}
