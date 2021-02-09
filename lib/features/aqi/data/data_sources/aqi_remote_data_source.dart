import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';

import '../../../../core/client/aqi_client.dart';
import '../../../../core/error/exceptions.dart';
import '../models/aqi_model.dart';




abstract class AqiRemoteDataSource {
  /// Calls the https://api.waqi.info/ endpoint
  ///
  /// Throws a [ServerException] for all error codes.
  Future<AqiModel> getAqi();
}


class AqiRemoteDataSourceImplementation implements AqiRemoteDataSource {
  AqiRemoteDataSourceImplementation({@required this.client});

  AqiClient client;

  @override
  Future<AqiModel> getAqi() async {
    var _position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    var _lat = '${_position.longitude}';
    var _lon = '${_position.latitude}';

    var _token = '${env['TOKEN']}';

    var response = await client.getAqi(_lat, _lon, _token);

    if (response != null) {
      return response;
    } else {
      throw ServerException();
    }
  }
}