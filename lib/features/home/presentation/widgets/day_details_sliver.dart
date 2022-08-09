import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather/features/global_widgets/default_loading.dart';
import 'package:weather/features/home/domain/day.dart';
import 'package:weather/features/home/presentation/home_screen_controller.dart';
import 'package:weather/utils/extensions.dart';

class DayDetailsSliver extends StatelessWidget {
  const DayDetailsSliver({
    this.portraitMode = true,
    Key? key,
  }) : super(key: key);

  final bool portraitMode;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Consumer(
        builder: (context, ref, child) {
          final state = ref.watch(homeScreenStateProvider);
          if (state.isLoading) {
            return const DefaultLoadingWidget();
          }
          final controller = ref.read(homeScreenStateProvider.notifier);
          final day = controller.selectedDay;
          final weatherDay = day?.weather.first;
          final cityName = controller.weather?.city.name ?? '';
          final symbol = controller.scaleSymbol;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 34.0, vertical: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Text(
                    day!.dt_txt.weekdayName,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 28,
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  cityName,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                Text(
                  weatherDay?.main ?? '',
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                _MainInfo(
                  portraitMode: portraitMode,
                  day: day,
                  symbol: symbol,
                  weatherDay: weatherDay,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _MainInfo extends StatelessWidget {
  const _MainInfo({
    required this.portraitMode,
    required this.day,
    required this.weatherDay,
    required this.symbol,
    Key? key,
  }) : super(key: key);

  final bool portraitMode;
  final Day day;
  final WeatherDay? weatherDay;
  final String symbol;

  @override
  Widget build(BuildContext context) {
    return portraitMode
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: _DayImage(
                      weatherDay?.icon ?? '',
                      portraitMode: portraitMode,
                    ),
                  ),
                  Center(
                    child: Text(
                      '${day.main.temp}$symbol',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 44,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              _DayInfo(day),
            ],
          )
        : Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Center(
                    child: _DayImage(
                      weatherDay?.icon ?? '',
                      portraitMode: portraitMode,
                    ),
                  ),
                  Center(
                    child: Text(
                      '${day.main.temp}$symbol',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 44,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              _DayInfo(day),
            ],
          );
  }
}

class _DayInfo extends StatelessWidget {
  const _DayInfo(this.day, {Key? key}) : super(key: key);

  final Day day;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Humidity: ${day.main.humidity}%',
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        Text(
          'Pressure: ${day.main.pressure}hPa',
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        Text(
          'Wind: ${day.wind.speed}hm/h',
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}

class _DayImage extends StatelessWidget {
  const _DayImage(
    this.iconName, {
    required this.portraitMode,
    Key? key,
  }) : super(key: key);

  final String iconName;
  final bool portraitMode;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      'http://openweathermap.org/img/wn/$iconName@4x.png',
      width: MediaQuery.of(context).size.width * (portraitMode ? 0.7 : 0.3),
      fit: BoxFit.fitWidth,
    );
  }
}
