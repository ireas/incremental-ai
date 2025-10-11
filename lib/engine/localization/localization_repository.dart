import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:incremental_ai/engine/localization/language.dart';
import 'package:incremental_ai/engine/localization/localization.dart';
import 'package:incremental_ai/engine/localization/persistence/yaml_loader.dart';
import 'package:incremental_ai/engine/localization/usecase/localization_placeholder_usecase.dart';
import 'package:logger/logger.dart';

/// Repository for localizations that holds currently active language and localizations for all languages.
class LocalizationRepository {
  final Logger _logger = Logger();
  final Map<Language, Localization> _localizations = {};
  Language currentLanguage = Language.english;

  /// Loads and caches localization for each language from assets.
  Future<void> initialize() async {
    _logger.t("Initializing localization repository.");

    await _addLocalization(Language.english, "assets/localization/en.yaml");
    await _addLocalization(Language.german, "assets/localization/de.yaml");
  }

  /// Validates this repository.
  void validate() {
    // verify that each language has a map
    for (Language language in Language.values) {
      if (!_localizations.containsKey(language)) {
        _logger.e("No localization found for $language!");
      }
    }

    Map<String, String> defaultLookupTable = fetchCurrentLocalization().lookupTable;

    for (MapEntry<Language, Localization> entry in _localizations.entries) {
      // verify that all localizations have seme set of keys
      if (!setEquals(defaultLookupTable.keys.toSet(), entry.value.lookupTable.keys.toSet())) {
        _logger.e("Localization keys does not match for ${entry.key} and $currentLanguage!");
      }

      // verify that each translated string has same number of placeholders for same key
      LocalizationPlaceholderUsecase usecase = GetIt.I<LocalizationPlaceholderUsecase>();
      for (MapEntry<String, String> lookupTable in entry.value.lookupTable.entries) {
        String defaultValue = defaultLookupTable[lookupTable.key]!;
        if (usecase.numberOfPlaceholders(lookupTable.value) != usecase.numberOfPlaceholders(defaultValue)) {
          _logger.e("Localization values placeholders count mismatch: ${lookupTable.value} and $defaultValue!");
        }
      }
    }
  }

  /// Fetches the currently active localization.
  Localization fetchCurrentLocalization() {
    return _localizations[currentLanguage]!;
  }

  /// Loads a localization file from [assetPath] from YAML file and registers a localization for [language].
  Future<void> _addLocalization(Language language, String assetPath) async {
    _logger.t("Loading Localization for $language from $assetPath.");

    Map<String, String> lookupTable = await YamlLoader(assetPath).loadFlatDartMap();
    _localizations[language] = Localization(language: language, lookupTable: lookupTable);
  }
}
