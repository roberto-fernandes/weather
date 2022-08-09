import 'package:flutter/material.dart';
import 'package:weather/features/home/domain/day.dart';
import 'package:weather/utils/extensions.dart';

class DayListSliver extends StatelessWidget {
  const DayListSliver({
    required this.days,
    required this.symbol,
    Key? key,
  }) : super(key: key);

  final List<Day>? days;
  final String symbol;

  @override
  Widget build(BuildContext context) {
    if (days == null || days!.isEmpty) {
      return const SliverToBoxAdapter(child: SizedBox());
    }
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
        height: 170.0,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: days!.length,
          itemBuilder: (context, index) {
            final item = days![index];
            final dayWeather = item.weather.first;
            final dayMain = item.main;
            return SizedBox(
              width: 170.0,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Text(
                        item.dt_txt.shortWeekdayName,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Image.network(
                            'http://openweathermap.org/img/wn/${dayWeather.icon}@4x.png',
                          ),
                        ),
                      ),
                      Text('${dayMain.temp_min}$symbol/${dayMain.temp_max}$symbol'),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
