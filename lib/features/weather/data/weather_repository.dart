import 'dart:math';

class WeatherRepository {
  WeatherRepository._();
  static WeatherRepository instace = WeatherRepository._();
  final num = Random().nextInt(100);
  int getWeather() {
    return num;
  }

  Future<String> getWeatherMessage() async {
    await Future.delayed(const Duration(seconds: 1));
    return 'Double of temeprature is ${num * 2}';
  }
}