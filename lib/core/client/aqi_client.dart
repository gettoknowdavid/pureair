import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../features/aqi/data/models/aqi_model.dart';
import '../../features/search/data/models/search_aqi_model.dart';

part 'aqi_client.g.dart';

@RestApi(baseUrl: 'https://api.waqi.info')
abstract class AqiClient {
  factory AqiClient(Dio dio, {String baseUrl}) = _AqiClient;

  @GET('/feed/geo:{lat};{lon}/?')
  Future<AqiModel> getAqi(
    @Path('lat') String lat,
    @Path('lon') String lon,
    @Query('token') String token,
  );

  @GET('/search/?')
  Future<SearchAqiModel> searchCity(
    @Query('token') String token,
    @Query('keyword') String keyword,
  );
}
