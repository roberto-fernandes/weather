import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:weather/features/global_widgets/default_error.dart';
import 'package:weather/features/global_widgets/default_loading.dart';
import 'package:weather/features/global_widgets/orientation_widget.dart';
import 'package:weather/features/home/presentation/home_screen_controller.dart';
import 'package:weather/features/home/presentation/widgets/day_details_sliver.dart';
import 'package:weather/features/home/presentation/widgets/day_list_sliver.dart';
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
          if (state.isLoading) {
            return const LoadingScreen();
          } else if (state.hasError) {
            return DefaultErrorWidget(
              tryAgainAction: () {
                ref.read(homeScreenStateProvider.notifier).loadWeather();
              },
            );
          }

          return RefreshIndicator(
            onRefresh: () {
              return ref.read(homeScreenStateProvider.notifier).loadWeather();
            },
            child: const OrientationWidget(
              portrait: _WeatherInformationPortrait(),
              landscape: _WeatherInformationLandscape(),
            ),
          );
        },
      ),
    );
  }
}

class _WeatherInformationPortrait extends StatelessWidget {
  const _WeatherInformationPortrait();

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      slivers: [
        DayDetailsSliver(),
        DayListSliver(),
      ],
    );
  }
}

class _WeatherInformationLandscape extends StatelessWidget {
  const _WeatherInformationLandscape();

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: SizedBox(height: 10,),
        ),
        DayListSliver(portraitMode: false),
        DayDetailsSliver(portraitMode: false),
      ],
    );
  }
}
