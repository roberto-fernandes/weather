import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class WeatherRepository {
  int getWeather();

  Future<String> getWeatherMessage();
}

class WeatherRepositoryImplementation implements WeatherRepository {
  final num = Random().nextInt(100);

  @override
  int getWeather() {
    return num;
  }

  @override
  Future<String> getWeatherMessage() async {
    await Future.delayed(const Duration(seconds: 1));
    return 'Double of temeprature is ${num * 2}';
  }
}

final weatherRepositoryProvider =
    Provider.autoDispose<WeatherRepository>((ref) {
  return WeatherRepositoryImplementation();
});

final weatherMessageProvider = FutureProvider.autoDispose<String>((ref) {
  final weatherRepository = ref.watch(weatherRepositoryProvider);
  return weatherRepository.getWeatherMessage();
});
