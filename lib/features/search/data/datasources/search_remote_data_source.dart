import 'dart:async';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:meta/meta.dart';

import '../../../../core/client/aqi_client.dart';
import '../../../../core/error/exceptions.dart';
import '../../../aqi/data/models/aqi_model.dart';
import '../models/search_aqi_model.dart';

abstract class SearchRemoteDataSource {
  Future<SearchAqiModel> searchCity(String city);

  Future<AqiModel> getSearchDetails(double lat, double lon);
}

class SearchRemoteDataSourceImplementation implements SearchRemoteDataSource {
  SearchRemoteDataSourceImplementation({@required this.client});
  final AqiClient client;

  @override
  Future<AqiModel> getSearchDetails(double lat, double lon) async {
    var _token = '${env['TOKEN']}';

    var response = await client.getAqi(lat.toString(), lon.toString(), _token);

    if (response != null) {
      return response;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<SearchAqiModel> searchCity(String city) async {
    var _token = '${env['TOKEN']}';

    var response = await client.searchCity(_token, city);

    if (response != null) {
      return response;
    } else {
      throw ServerException();
    }
  }
}
