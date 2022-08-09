import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather/features/home/data/home_repository.dart';
import 'package:weather/features/home/domain/day.dart';
import 'package:weather/features/home/domain/weather.dart';
import 'package:weather/features/settings/data/settings_repository.dart';
import 'package:weather/utils/extensions.dart';

class HomeScreenController extends StateNotifier<AsyncValue> {
  HomeScreenController({
    required this.homeRepository,
    required this.settingsRepository,
  }) : super(const AsyncValue.data(null));

  final HomeRepository homeRepository;
  final SettingsRepository settingsRepository;

  Weather? _weather;
  Weather? get weather => _weather;

  Day? _selectedDay;
  Day? get selectedDay => _selectedDay ?? _weather?.list.first;
  set selectedDay(Day? value) {
    _setLoadingState();
    _selectedDay = value;
    _setCompleteState();
  }

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
      final completeWeather = await homeRepository.getWeather(_scaleUnits);
      final uniqueDatesList = _getUniqueDays(completeWeather.list);
      _weather = completeWeather.copyWith(list: uniqueDatesList);
      _setCompleteState();
    } catch (error) {
      _setErrorState(error);
    }
    return _weather;
  }

  List<Day> _getUniqueDays(List<Day> list) {
    final myMap = <DateTime, Day>{};
    for (Day day in list) {
      final dateTime = day.dt_txt.startOfDay;
      if(myMap[dateTime] == null) {
        myMap[dateTime] = day;
      }
    }
    return myMap.values.toList();
  }

  void _setCompleteState() {
    state = const AsyncValue.data(null);
  }

  void _setErrorState(Object error) {
    state = AsyncValue.error(error);
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
