import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pureair/src/core/aqi_client.dart';
import 'package:pureair/src/core/base_model.dart';
import 'package:pureair/src/core/server_error.dart';
import 'package:pureair/src/model/aqi.dart';
import 'package:pureair/src/model/search_model/geo.dart';
import 'package:pureair/src/model/search_model/search_aqi.dart';

class Dao {
  Dio dio;
  AqiClient client;

  Dao() {
    dio = Dio();
    client = AqiClient(dio);
  }

  String _token = '40ed6f6141a5da95083e7aa28ba7658e70bb90f6';

  Future<BaseModel<Aqi>> getAqi() async {
    Aqi response;
    Position position = await Geolocator().getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    String lon = '${position.latitude}';
    String lat = '${position.longitude}';

    try {
      response = await client.getAqi(lat, lon, _token);
      print(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stacktrace: $stacktrace");
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  Future<BaseModel<Aqi>> getSearchDetails(double lat, double lon) async {
    Aqi response;

    try {
      response = await client.getAqi('$lat', '$lon', _token);
    } catch (error, stacktrace) {
      print("Exception occured: $error stacktrace: $stacktrace");
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  Future<BaseModel<List<Aqi>>> getFavourites(List<Geo> geos) async {
    List<Aqi> responses;

    try {
      responses = await Future.wait(geos
          .map((e) async => await client.getAqi('${e.lat}', '${e.lon}', _token))
          .toList());
    } catch (error, stacktrace) {
      print("Exception occured: $error stacktrace: $stacktrace");
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = responses.toList();
  }

  Future<BaseModel<SearchAqi>> getSearchAqi(String keyword) async {
    SearchAqi response;

    try {
      response = await client.getSearchAqi(_token, keyword);
      print(response.data.map((e) => e.station.geo));
    } catch (error, stacktrace) {
      print("Exception occured: $error stacktrace: $stacktrace");
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }
}
