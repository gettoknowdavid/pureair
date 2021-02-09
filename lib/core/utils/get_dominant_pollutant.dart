import 'dart:math';

import '../../features/aqi/domain/entities/aqi.dart';

String _getDominantPollutantName(Aqi aqi) {
  var domPol = aqi.data.dominentpol;
  if (domPol == 'co') {
    return 'CO';
  } else if (domPol == 'no2') {
    return 'NO\u2082';
  } else if (domPol == 'o3') {
    return 'O\u2083';
  } else if (domPol == 'pm10') {
    return 'PM10';
  } else if (domPol == 'pm25') {
    return 'PM2.5';
  } else {
    return 'SO\u2082';
  }
}

int _getDominantPollutantValue(Aqi aqi) {
  var co = aqi.data.iaqi.co == null ? 0 : aqi.data.iaqi.co.v;
  var so2 = aqi.data.iaqi.so2 == null ? 0 : aqi.data.iaqi.so2.v;
  var no2 = aqi.data.iaqi.no2 == null ? 0 : aqi.data.iaqi.no2.v;
  var o3 = aqi.data.iaqi.o3 == null ? 0 : aqi.data.iaqi.o3.v;
  var pm10 = aqi.data.iaqi.pm10 == null ? 0 : aqi.data.iaqi.pm10.v;
  var pm25 = aqi.data.iaqi.pm25 == null ? 0 : aqi.data.iaqi.pm25.v;

  final numbers = [co, so2, no2, o3, pm10, pm25];
  final dominantValue = numbers.reduce(max);
  return dominantValue.toInt();
}

Map<String, int> getDomPol(Aqi aqi) {
  final _title = _getDominantPollutantName(aqi);
  final _value = _getDominantPollutantValue(aqi);

  return {_title: _value};
}
