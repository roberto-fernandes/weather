import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather/features/home/data/home_repository.dart';
import 'package:weather/features/home/domain/day.dart';

class HomeScreenController extends StateNotifier<AsyncValue> {
  HomeScreenController({required this.homeRepository})
      : super(const AsyncValue.data(null));

  final HomeRepository homeRepository;

  Day? _day;
  Day? get day => _day;

  void init() {
    loadWeather();
  }

  Future<Day?> loadWeather() async {
    _setLoadingState();
    try {
      _day = await homeRepository.getWeather();
      state = const AsyncValue.data(null);
    } catch (error) {
      state = AsyncValue.error(error);
    }
    return _day;
  }

  void _setLoadingState() {
    state = const AsyncValue.loading();
  }
}

final homeScreenStateProvider =
    StateNotifierProvider.autoDispose<HomeScreenController, AsyncValue>(
  (ref) {
    final repository = ref.watch(homeRepositoryProvider);
    final controller = HomeScreenController(homeRepository: repository);
    controller.init();
    return controller;
  },
);

final weatherProvider = FutureProvider.autoDispose<Day?>((ref) {
  final controller = ref.watch(homeScreenStateProvider.notifier);
  return controller.loadWeather();
});
