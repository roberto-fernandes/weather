import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class WeatherRepository {
  final num = Random().nextInt(100);

  int getWeather() {
    return num;
  }

  Future<String> getWeatherMessage() async {
    await Future.delayed(const Duration(seconds: 1));
    return 'Double of temeprature is ${num * 2}';
  }
}

final weatherRepositoryProvider = Provider.autoDispose<WeatherRepository>((ref) {
  return WeatherRepository();
});

final weatherMessageProvider = FutureProvider.autoDispose<String>((ref) {
  final weatherRepository = ref.watch(weatherRepositoryProvider);
  return weatherRepository.getWeatherMessage();
});