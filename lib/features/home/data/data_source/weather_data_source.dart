import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather/features/home/data/data_source/remote/weather_remote_data_source.dart';
import 'package:weather/features/home/domain/weather.dart';

abstract class WeatherDataSource {
  Future<Weather> getWeather({
    required double lat,
    required double lon,
    required int cnt,
    required String units,
  });
}

final remoteWeatherDataSourceProvider = Provider<WeatherDataSource>((ref) {
  return WeatherRemoteDataSource();
});