import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:weather/features/weather/data/weather_repository.dart';
import 'package:weather/localization/string_hardcoded.dart';
import 'package:weather/routing/app_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final value = WeatherRepository.instace.getWeather();
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather'.hardcoded),
        actions: [
          InkWell(
            onTap: () => context.pushNamed(AppRoute.settings.name),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.settings,
                size: 36.0,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
          child: Center(
        child: Text(value.toString()),
      )),
    );
  }
}
