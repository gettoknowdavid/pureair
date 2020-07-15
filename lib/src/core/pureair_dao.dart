import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pureair/src/model/aqi.dart';
import 'package:pureair/src/model/search_model/search_aqi.dart';

class Dao {
  double lon = 2.3522;
  double lat = 48.8566;
  Future<Aqi> fetchAqi() async {
    String url =
        'https://api.waqi.info/feed/geo:${lat.toString()};${lon.toString()}/?token=40ed6f6141a5da95083e7aa28ba7658e70bb90f6';

    final response = await http.Client().get(url).timeout(
          Duration(seconds: 20),
          onTimeout: () => null,
        );

    print(response.body);

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      return Aqi.fromJson(json);
    } else {
      throw Exception('Error getting Air Quality data');
    }
  }

  Future<SearchAqi> searchAqi(String city) async {
    String url =
        'https://api.waqi.info/search/?token=40ed6f6141a5da95083e7aa28ba7658e70bb90f6&keyword=$city';

    final response = await http.Client().get(url).timeout(
          Duration(seconds: 40),
          onTimeout: () => null,
        );

    if (response.statusCode == 200) {
      print('SEARCH SUCCESSFUL');
      var json = jsonDecode(response.body);
      return SearchAqi.fromJson(json);
    } else {
      throw Exception('Error getting Air Quality data');
    }
  }

  
}
