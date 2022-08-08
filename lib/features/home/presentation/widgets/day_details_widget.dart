import 'package:flutter/material.dart';
import 'package:weather/features/home/domain/weather.dart';

class DayDetailsSliver extends StatelessWidget {
  const DayDetailsSliver({
    required this.weather,
    required this.symbol,
    Key? key,
  }): super(key: key);

  final Weather? weather;
  final String symbol;

  @override
  Widget build(BuildContext context) {
    if (weather == null) {
      return const SliverToBoxAdapter(child:  SizedBox());
    }
    return SliverToBoxAdapter(
      child: Container(
        height: 1000,
        width: 100,
        color: Colors.red,
        child: Column(
          children: [
            Text(weather!.city.name),
            Text(weather!.list.first.main.temp.toString()),
            Text(symbol),
          ],
        ),
      ),
    );
  }
}
