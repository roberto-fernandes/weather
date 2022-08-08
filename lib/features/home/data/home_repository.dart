import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather/features/home/domain/day.dart';

abstract class HomeRepository {
  Future<String> getWeatherMessage();

  Future<Day> getWeather();
}

class HomeRepositoryImplementation implements HomeRepository {
  final num = Random().nextInt(100);

  @override
  Future<String> getWeatherMessage() async {
    await Future.delayed(const Duration(seconds: 1));
    return 'Double of temeprature is ${num * 2}';
  }

  @override
  Future<Day> getWeather() async {
    await Future.delayed(const Duration(seconds: 2));
    return Day(dayOfTheWeek: 'Friday${Random().nextInt(100)}');
  }
}

final homeRepositoryProvider = Provider.autoDispose<HomeRepository>((ref) {
  return HomeRepositoryImplementation();
});

final homeMessageProvider = FutureProvider.autoDispose<String>((ref) {
  final homeRepository = ref.watch(homeRepositoryProvider);
  return homeRepository.getWeatherMessage();
});
