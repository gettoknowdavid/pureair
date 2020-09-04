// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aqi_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _AqiClient implements AqiClient {
  _AqiClient(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    this.baseUrl ??= 'https://api.waqi.info';
  }

  final Dio _dio;

  String baseUrl;

  @override
  getAqi(lat, lon, token) async {
    ArgumentError.checkNotNull(lat, 'lat');
    ArgumentError.checkNotNull(lon, 'lon');
    ArgumentError.checkNotNull(token, 'token');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'token': token};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/feed/geo:$lat;$lon/?',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = Aqi.fromJson(_result.data);
    return value;
  }

  @override
  getSearchAqi(token, keyword) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(keyword, 'keyword');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'token': token,
      r'keyword': keyword
    };
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/search/?',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = SearchAqi.fromJson(_result.data);
    return value;
  }
}
