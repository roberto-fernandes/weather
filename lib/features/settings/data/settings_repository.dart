import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather/utils/in_memory_store.dart';
import 'package:weather/utils/string_extension.dart';

enum Scale {
  celsius,
  fahrenheit,
}

enum Languages { english }

abstract class SettingsRepository {
  List<String> getScales();

  String selectedScale();

  Future<void> changeScale(String scale);

  List<String> getLanguages();

  String selectedLanguage();

  Stream<String> tempSlectedScale();
}

class SettingsRepositoryImplementation implements SettingsRepository {
  final _inMemoryScale = InMemoryStore<String>(Scale.values.first.name);

  @override
  List<String> getScales() {
    return Scale.values.map((e) => e.name.capitalized).toList();
  }

  @override
  String selectedScale() {
    return _inMemoryScale.value.capitalized;
  }

  @override
  List<String> getLanguages() {
    return Languages.values.map((e) => e.name.capitalized).toList();
  }

  @override
  String selectedLanguage() {
    return getLanguages().first;
  }

  void dispose() => _inMemoryScale.close();

  @override
  Future<void> changeScale(String scale) async {
    await Future.delayed(const Duration(seconds: 2));
    _inMemoryScale.value = scale;
  }

  @override
  Stream<String> tempSlectedScale() {
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

final selectedScaleProvider = Provider<String>((ref) {
  final repository = ref.watch(settingsRepositoryProvider);
  return repository.selectedScale();
});

final languagesProvider = Provider<List<String>>((ref) {
  final repository = ref.watch(settingsRepositoryProvider);
  return repository.getLanguages();
});

final selectedLanguageProvider = Provider<String>((ref) {
  final repository = ref.watch(settingsRepositoryProvider);
  return repository.selectedLanguage();
});

final tempProvider = StreamProvider<String>((ref) {
  final repository = ref.watch(settingsRepositoryProvider);
  return repository.tempSlectedScale();
});
