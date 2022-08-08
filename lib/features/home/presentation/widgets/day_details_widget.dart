import 'package:flutter/material.dart';
import 'package:weather/features/home/domain/day.dart';

class DayDetailsSliver extends StatelessWidget {
  const DayDetailsSliver({
    required this.day,
    super.key,
  });

  final Day? day;

  @override
  Widget build(BuildContext context) {
    if (day == null) {
      return const SliverToBoxAdapter(child:  SizedBox());
    }
    return SliverToBoxAdapter(
      child: Container(
        height: 1000,
        width: 100,
        color: Colors.red,
        child: Text(day!.dayOfTheWeek),
      ),
    );
  }
}
