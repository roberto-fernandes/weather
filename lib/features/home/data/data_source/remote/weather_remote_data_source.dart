import 'package:dio/dio.dart';
import 'package:weather/features/home/data/data_source/remote/weather_remote_client.dart';
import 'package:weather/features/home/data/data_source/weather_data_source.dart';
import 'package:weather/features/home/domain/weather.dart';

const _appid = 'ae1c6760efbf39870807c205127498fb';

class WeatherRemoteDataSource extends WeatherDataSource {
  final client = WeatherRemoteClient(Dio());

  @override
  Future<Weather> getWeather({
    required double lat,
    required double lon,
    required int cnt,
    required String units,
  }) async {
    return client.getWeather(
        lat: lat, lon: lon, cnt: cnt, units: units, appid: _appid);
  }
}
