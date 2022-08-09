import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather/features/global_widgets/default_loading.dart';
import 'package:weather/features/home/presentation/home_screen_controller.dart';
import 'package:weather/utils/extensions.dart';

class DayDetailsSliver extends StatelessWidget {
  const DayDetailsSliver({
    Key? key,
  }) : super(key: key);

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
                  weatherDay?.main ?? '',
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                Center(
                  child: Image.network(
                    'http://openweathermap.org/img/wn/${weatherDay?.icon}@4x.png',
                    width: MediaQuery.of(context).size.width * 0.7,
                    fit: BoxFit.fitWidth,
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
                const SizedBox(height: 14),
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
            ),
          );
        },
      ),
    );
  }
}
