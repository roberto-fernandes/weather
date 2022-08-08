import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:weather/features/global_widgets/default_error.dart';
import 'package:weather/features/global_widgets/default_loading.dart';
import 'package:weather/features/home/domain/weather.dart';
import 'package:weather/features/home/presentation/home_screen_controller.dart';
import 'package:weather/features/home/presentation/widgets/day_details_widget.dart';
import 'package:weather/localization/string_hardcoded.dart';
import 'package:weather/routing/app_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      body: Consumer(
        builder: (context, ref, child) {
          final state = ref.watch(homeScreenStateProvider);
          final symbol =
              ref.watch(homeScreenStateProvider.notifier).scaleSymbol;
          if (state.isLoading) {
            return const LoadingScreen();
          } else if (state.hasError) {
            return DefaultErrorWidget(
              tryAgainAction: () {
                ref.read(homeScreenStateProvider.notifier).loadWeather();
              },
            );
          }
          final weather = ref.watch(homeScreenStateProvider.notifier).weather;
          return RefreshIndicator(
            onRefresh: () {
              return ref.read(homeScreenStateProvider.notifier).loadWeather();
            },
            child: _WeatherInformation(weather, symbol),
          );
        },
      ),
    );
  }
}

class _WeatherInformation extends StatelessWidget {
  const _WeatherInformation(this.weather, this.symbol);

  final Weather? weather;
  final String symbol;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        DayDetailsSliver(
          weather: weather,
          symbol: symbol,
        ),
        SliverToBoxAdapter(
          child: Container(
            height: 200,
            color: Colors.yellow,
          ),
        )
      ],
    );
  }
}
