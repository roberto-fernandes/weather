import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather/features/home/data/home_repository.dart';
import 'package:weather/features/home/domain/weather.dart';
import 'package:weather/features/settings/data/settings_repository.dart';

class HomeScreenController extends StateNotifier<AsyncValue> {
  HomeScreenController({
    required this.homeRepository,
    required this.settingsRepository,
  }) : super(const AsyncValue.data(null));

  final HomeRepository homeRepository;
  final SettingsRepository settingsRepository;

  Weather? _weather;

  Weather? get weather => _weather;

  bool get _inCelsius =>_scale == Scale.celsius.name;

  String _scale = Scale.celsius.name;

  String get _scaleUnits {
    return _inCelsius ? 'metric' : 'imperial';
  }

  String get scaleSymbol {
    return _inCelsius ? 'ºC' : 'ºF';
  }

  void init() {
    settingsRepository.selectedScaleStream().listen((scale) {
      if (scale != _scale) {
        _scale = scale;
        loadWeather();
      }
    });
    loadWeather();
  }

  Future<Weather?> loadWeather() async {
    _setLoadingState();
    try {
      _weather = await homeRepository.getWeather(_scaleUnits);
      state = const AsyncValue.data(null);
    } catch (error) {
      state = AsyncValue.error(error);
    }
    return _weather;
  }

  void _setLoadingState() {
    state = const AsyncValue.loading();
  }
}

final homeScreenStateProvider =
    StateNotifierProvider.autoDispose<HomeScreenController, AsyncValue>(
  (ref) {
    final homeRepository = ref.watch(homeRepositoryProvider);
    final settingsRepository = ref.watch(settingsRepositoryProvider);
    final controller = HomeScreenController(
      homeRepository: homeRepository,
      settingsRepository: settingsRepository,
    );
    controller.init();
    return controller;
  },
);
