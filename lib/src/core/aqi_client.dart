import 'package:dio/dio.dart';
import 'package:pureair/src/model/aqi.dart';
import 'package:pureair/src/model/search_model/search_aqi.dart';
import 'package:retrofit/retrofit.dart';

part 'aqi_client.g.dart';

@RestApi(baseUrl: 'https://api.waqi.info')
abstract class AqiClient {
  factory AqiClient(Dio dio, {String baseUrl}) = _AqiClient;

  @GET('/feed/geo:{lat};{lon}/?')
  Future<Aqi> getAqi(
    @Path('lat') String lat,
    @Path('lon') String lon,
    @Query('token') String token,
  );

  @GET('/search/?')
  Future<SearchAqi> getSearchAqi(
    @Query('token') String token,
    @Query('keyword') String keyword,
  );
}
