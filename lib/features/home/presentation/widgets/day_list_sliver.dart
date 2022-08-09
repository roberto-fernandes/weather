import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather/features/home/presentation/home_screen_controller.dart';
import 'package:weather/utils/extensions.dart';

class DayListSliver extends StatelessWidget {
  const DayListSliver({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Consumer(
        builder: (context, ref, child) {
          final controller = ref.read(homeScreenStateProvider.notifier);
          final days = controller.weather?.list;
          final symbol =controller.scaleSymbol;
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
            height: 170.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: days?.length,
              itemBuilder: (context, index) {
                final item = days![index];
                final dayWeather = item.weather.first;
                final dayMain = item.main;
                return SizedBox(
                  width: 170.0,
                  child: InkWell(
                    onTap: () {
                      ref.read(homeScreenStateProvider.notifier).selectedDay = item;
                    },
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
                            Text(
                                '${dayMain.temp_min}$symbol/${dayMain.temp_max}$symbol'),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
