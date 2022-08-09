import 'package:flutter/material.dart';
import 'package:weather/features/home/domain/day.dart';
import 'package:weather/utils/extensions.dart';

class DayDetailsSliver extends StatelessWidget {
  const DayDetailsSliver({
    required this.day,
    required this.cityName,
    required this.symbol,
    Key? key,
  }) : super(key: key);

  final Day? day;
  final String cityName;
  final String symbol;

  WeatherDay? get _weatherDay => day?.weather.first;

  @override
  Widget build(BuildContext context) {
    if (day == null) {
      return const SliverToBoxAdapter(child: SizedBox());
    }
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 34.0, vertical: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
              _weatherDay?.main ?? '',
             style: const TextStyle(
                fontSize: 16,
              ),
            ),
            Center(
              child: Image.network(
                'http://openweathermap.org/img/wn/${_weatherDay?.icon}@4x.png',
                width: MediaQuery.of(context).size.width * 0.7,
                fit: BoxFit.fitWidth,
              ),
            ),
            Center(
              child: Text(
                '${day!.main.temp}$symbol',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 44,
                ),
              ),
            ),
            const SizedBox(height: 14),
            Text(
              'Humidity: ${day!.main.humidity}%',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            Text(
              'Pressure: ${day!.main.pressure}hPa',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            Text(
              'Wind: ${day!.wind.speed}hm/h',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
