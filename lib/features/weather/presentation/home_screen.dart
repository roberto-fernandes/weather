import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:weather/features/global_widgets/default_loading.dart';
import 'package:weather/features/settings/data/settings_repository.dart';
import 'package:weather/features/weather/data/weather_repository.dart';
import 'package:weather/localization/string_hardcoded.dart';
import 'package:weather/routing/app_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
      body: SafeArea(
        child: Column(
          children: [
            Consumer(
              builder: (context, ref, _) {
                final value = ref.watch(weatherMessageProvider);
                return value.when(data: (message) {
                  return Center(
                    child: Text(message),
                  );
                }, error: (error, stack) {
                  return const Center(
                    child: Text('error'), //todo
                  );
                }, loading: () {
                  return const DefaultLoadingWidget();
                });
              },
            ),
            Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                final scale = ref.watch(tempProvider);
                return scale.when(data: (scale) {
                  return Text('stream: $scale');
                }, error: (_, __) {
                  return const SizedBox();
                }, loading: () {
                  return const SizedBox();
                });
              },
            ),
            Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                final scale = ref.watch(selectedScaleProvider);
                return Text('sync: $scale');
              },
            ),
          ],
        ),
      ),
    );
  }
}
