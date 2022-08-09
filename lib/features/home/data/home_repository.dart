import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather/features/home/data/data_source/weather_data_source.dart';
import 'package:weather/features/home/domain/weather.dart';

abstract class HomeRepository {
  Future<String> getWeatherMessage();

  Future<Weather> getWeather(String units);
}

class HomeRepositoryImplementation implements HomeRepository {

  HomeRepositoryImplementation(this._weatherDataSource);

  final WeatherDataSource _weatherDataSource;
  final num = Random().nextInt(100);

  @override
  Future<String> getWeatherMessage() async {
    await Future.delayed(const Duration(seconds: 1));
    return 'Double of temeprature is ${num * 2}';
  }

  @override
  Future<Weather> getWeather(String units) async {
    const lat = 41.1579;
    const lon = -8.6290;
    const cnt = 100;
    return _weatherDataSource.getWeather(lat: lat, lon: lon, cnt: cnt, units: units);
  }
}

final homeRepositoryProvider = Provider.autoDispose<HomeRepository>((ref) {
  final remoteDataSource = ref.read(remoteWeatherDataSourceProvider);
  return HomeRepositoryImplementation(remoteDataSource);
});

final homeMessageProvider = FutureProvider.autoDispose<String>((ref) {
  final homeRepository = ref.watch(homeRepositoryProvider); //todo read?
  return homeRepository.getWeatherMessage();
});
