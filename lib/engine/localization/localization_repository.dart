import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:incremental_ai/engine/localization/action/localization_placeholder_action.dart';
import 'package:incremental_ai/engine/localization/language.dart';
import 'package:incremental_ai/engine/localization/localization.dart';
import 'package:incremental_ai/engine/localization/persistence/yaml_loader.dart';
import 'package:logger/logger.dart';

/// Repository for localizations that holds currently active language and localizations for all languages.
class LocalizationRepository {
  static LocalizationRepository get instance => GetIt.I<LocalizationRepository>();

  final Logger _logger = Logger();

  /// Localization lookup tables mapped to their language.
  final Map<Language, Localization> _localizations = {};

  /// Currently active language.
  Language currentLanguage = Language.english;

  /// Loads and caches localization for each language from assets.
  Future<void> initialize() async {
    _logger.t("Initializing localization repository.");

    // load localization for each language
    await _addLocalization(Language.english, "assets/localization/en.yaml");
    await _addLocalization(Language.german, "assets/localization/de.yaml");
  }

  /// Validates this repository.
  /// - each defied language has a localization lookup table
  /// - each localization lookup table must have same set of keys
  /// - each lookup table entry must have same number of placeholder as others with same key
  void validate() {
    // verify that each language has a map
    for (Language language in Language.values) {
      if (!_localizations.containsKey(language)) {
        _logger.e("No localization found for $language!");
      }
    }

    Map<String, String> defaultLookupTable = fetchCurrentLocalization().lookupTable;

    for (MapEntry<Language, Localization> entry in _localizations.entries) {
      // verify that all localizations have same set of keys
      if (!setEquals(defaultLookupTable.keys.toSet(), entry.value.lookupTable.keys.toSet())) {
        _logger.e("Localization keys does not match for ${entry.key} and $currentLanguage!");
      }

      // verify that each translated string has same number of placeholders for same key
      LocalizationPlaceholderAction usecase = GetIt.I<LocalizationPlaceholderAction>();
      for (MapEntry<String, String> lookupTable in entry.value.lookupTable.entries) {
        String defaultValue = defaultLookupTable[lookupTable.key]!;
        if (usecase.numberOfPlaceholders(lookupTable.value) != usecase.numberOfPlaceholders(defaultValue)) {
          _logger.e("Localization values placeholders count mismatch: ${lookupTable.value} and $defaultValue!");
        }
      }
    }
  }

  /// Loads a localization file from [assetPath] from YAML file and registers a localization for [language].
  Future<void> _addLocalization(Language language, String assetPath) async {
    _logger.t("Loading Localization for $language from $assetPath.");

    Map<String, String> lookupTable = await YamlLoader(assetPath).loadFlatDartMap();
    _localizations[language] = Localization(language: language, lookupTable: lookupTable);
  }

  /// Fetches the currently active localization.
  Localization fetchCurrentLocalization() {
    return _localizations[currentLanguage]!;
  }
}
