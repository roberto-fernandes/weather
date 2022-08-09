import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather/utils/in_memory_store.dart';

enum Scale {
  celsius,
  fahrenheit,
}

enum Languages { english }

abstract class SettingsRepository {
  List<String> getScales();

  Future<void> changeScale(String scale);

  List<String> getLanguages();

  String selectedLanguage();

  Stream<String> selectedScaleStream();
}

class SettingsRepositoryImplementation implements SettingsRepository {
  final _inMemoryScale = InMemoryStore<String>(Scale.values.first.name);

  @override
  List<String> getScales() {
    return Scale.values.map((e) => e.name).toList();
  }

  @override
  List<String> getLanguages() {
    return Languages.values.map((e) => e.name).toList();
  }

  @override
  String selectedLanguage() {
    return getLanguages().first;
  }

  void dispose() => _inMemoryScale.close();

  @override
  Future<void> changeScale(String scale) async {
    _inMemoryScale.value = scale;
  }

  @override
  Stream<String> selectedScaleStream() {
    return _inMemoryScale.stream;
  }
}

final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  final repository = SettingsRepositoryImplementation();
  ref.onDispose(() {
    repository.dispose();
  });
  return repository;
});

final scalesProvider = Provider<List<String>>((ref) {
  final repository = ref.watch(settingsRepositoryProvider);
  return repository.getScales();
});

final languagesProvider = Provider<List<String>>((ref) {
  final repository = ref.watch(settingsRepositoryProvider);
  return repository.getLanguages();
});

final selectedLanguageProvider = Provider<String>((ref) {
  final repository = ref.watch(settingsRepositoryProvider);
  return repository.selectedLanguage();
});

final selectedScaleStreamProvider = StreamProvider.autoDispose<String>((ref) {
  final repository = ref.watch(settingsRepositoryProvider);
  return repository.selectedScaleStream();
});
