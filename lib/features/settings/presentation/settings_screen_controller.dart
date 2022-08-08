import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather/features/settings/data/settings_repository.dart';

class SettingsScreenController extends StateNotifier<AsyncValue> {
  SettingsScreenController({required this.settingsRepository})
      : super(const AsyncValue.data(null));

  final SettingsRepository settingsRepository;

  Future<void> changeScale(String scale) async {
    _setLoadingState();
    state = await AsyncValue.guard(() => settingsRepository.changeScale(scale));
  }

  void _setLoadingState() {
    state = const AsyncValue.loading();
  }
}

final settingsScreenStateProvider =
    StateNotifierProvider.autoDispose<SettingsScreenController, AsyncValue<void>>(
  (ref) {
    final repository = ref.watch(settingsRepositoryProvider);
    return SettingsScreenController(settingsRepository: repository);
  },
);
