import 'dart:async';
import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:pureair/src/model/aqi.dart';
import 'package:pureair/src/model/search_model/search_aqi.dart';

class Dao {
  Future<Aqi> fetchAqi() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    double lon = position.latitude;
    double lat = position.longitude;

    String url =
        'https://api.waqi.info/feed/geo:${lat.toString()};${lon.toString()}/?token=40ed6f6141a5da95083e7aa28ba7658e70bb90f6';

    final response = await http.Client().get(url).timeout(
          Duration(seconds: 20),
          onTimeout: () => null,
        );

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      return Aqi.fromJson(json);
    } else {
      throw Exception('Error getting Air Quality data');
    }
  }

  Future<Aqi> fetchSearchDetails(double lat, double lon) async {
    String url =
        'https://api.waqi.info/feed/geo:${lat.toString()};${lon.toString()}/?token=40ed6f6141a5da95083e7aa28ba7658e70bb90f6';

    final response = await http.Client().get(url).timeout(
          Duration(seconds: 20),
          onTimeout: () => null,
        );

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
      var json = jsonDecode(response.body);
      return SearchAqi.fromJson(json);
    } else {
      throw Exception('Error getting Air Quality data');
    }
  }
}
