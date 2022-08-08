// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_remote_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _WeatherRemoteClient implements WeatherRemoteClient {
  _WeatherRemoteClient(this._dio, {this.baseUrl}) {
    baseUrl ??= 'https://api.openweathermap.org/data/2.5';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<Weather> getWeather(
      {required lat,
      required lon,
      required cnt,
      required units,
      required appid}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'lat': lat,
      r'lon': lon,
      r'cnt': cnt,
      r'units': units,
      r'appid': appid
    };
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Weather>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/forecast/',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = Weather.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
