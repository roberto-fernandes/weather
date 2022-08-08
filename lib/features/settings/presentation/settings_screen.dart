import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather/features/global_widgets/default_error_widget.dart';
import 'package:weather/features/global_widgets/default_loading.dart';
import 'package:weather/features/settings/data/settings_repository.dart';
import 'package:weather/features/settings/presentation/settings_screen_controller.dart';
import 'package:weather/localization/string_hardcoded.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(settingsScreenStateProvider);
    final selectedScaleTemp = ref.watch(selectedScaleProvider);
    final scalesTemp = ref.watch(scalesProvider);
    final hasError = !state.isRefreshing && state.hasError;
    if (state.isLoading) {
      return const LoadingScreen();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'.hardcoded),
      ),
      body: hasError
          ? const DefaultErrorWidget()
          : SafeArea(
              child: Column(
              children: [
                _OptionSelector(
                  title: 'Notif Scale'.hardcoded,
                  options: scalesTemp,
                  selectedOption: selectedScaleTemp,
                  onOptionSelected: (scale) {
                    ref
                        .read(settingsScreenStateProvider.notifier)
                        .changeScale(scale);
                  },
                ),
                Consumer(
                  builder:
                      (BuildContext context, WidgetRef ref, Widget? child) {
                    final scales = ref.watch(scalesProvider);
                    final repository = ref.read(settingsRepositoryProvider);
                    final scale = ref.watch(tempProvider);
                    return scale.when(data: (scale) {
                      return _OptionSelector(
                        title: 'Scale2'.hardcoded,
                        options: scales,
                        selectedOption: scale,
                        onOptionSelected: (scale) {
                          repository.changeScale(scale);
                        },
                      );
                    }, error: (_, __) {
                      return const SizedBox();
                    }, loading: () {
                      return const SizedBox();
                    });
                  },
                ),
                Consumer(
                  builder:
                      (BuildContext context, WidgetRef ref, Widget? child) {
                    final scales = ref.watch(scalesProvider);
                    final selectedScale = ref.watch(selectedScaleProvider);
                    final repository = ref.read(settingsRepositoryProvider);
                    return _OptionSelector(
                      title: 'Scale'.hardcoded,
                      options: scales,
                      selectedOption: selectedScale,
                      onOptionSelected: (scale) {
                        repository.changeScale(scale);
                      },
                    );
                  },
                ),
                Consumer(
                  builder:
                      (BuildContext context, WidgetRef ref, Widget? child) {
                    final languages = ref.watch(languagesProvider);
                    final selectedLanguage =
                        ref.watch(selectedLanguageProvider);
                    return _OptionSelector(
                      title: 'Language'.hardcoded,
                      options: languages,
                      selectedOption: selectedLanguage,
                      onOptionSelected: (_) {},
                    );
                  },
                ),
              ],
            )),
    );
  }
}

class _OptionSelector extends StatelessWidget {
  const _OptionSelector({
    required this.title,
    required this.options,
    required this.selectedOption,
    required this.onOptionSelected,
  });

  final String title;
  final List<String> options;
  final String selectedOption;
  final Function(String option) onOptionSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          PopupMenuButton<String>(
            offset: const Offset(2, 50),
            initialValue: selectedOption,
            color: Theme.of(context).colorScheme.surface,
            itemBuilder: (context) {
              return <PopupMenuEntry<String>>[
                for (final item in options)
                  PopupMenuItem<String>(
                    height: 18,
                    value: item,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(8.0),
                      child: Text(item),
                    ),
                  ),
              ];
            },
            onSelected: (choice) {
              onOptionSelected(choice);
            },
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(selectedOption),
                  const Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}