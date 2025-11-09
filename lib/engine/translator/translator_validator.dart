import 'package:flutter/foundation.dart';
import 'package:incremental_ai/engine/translator/enum/language.dart';
import 'package:incremental_ai/engine/translator/translation.dart';
import 'package:incremental_ai/engine/translator/translator.dart';
import 'package:incremental_ai/engine/utility/loggable.dart';

/// Validator class for [Translator].
class TranslatorValidator with Loggable {
  /// Regex to find placeholders formated as {placeholder_key} in raw translated strings.
  static final RegExp _placeholderRegex = RegExp(r'{.*?}');

  /// Target translation map to validate.
  final Map<Language, Translation> _translations;

  /// Constructor
  TranslatorValidator(this._translations);

  /// Validates the loaded translations.
  /// - each defied language has a translation lookup table
  /// - each translation lookup table must have same set of keys
  /// - each lookup table entry must have same number of placeholder as others with same key
  void validate() {
    // verify that each available language has a translation lookup table
    for (Language language in Language.values) {
      if (!_translations.containsKey(language)) {
        logger.w("No translation found for $language!");
      }
    }

    // fetch lookup table for default language that is used in comparisons
    Map<String, String> defaultLookupTable = Translator.instance
        .fetchTranslation(Translator.instance.currentLanguage)
        .lookupTable;

    for (MapEntry<Language, Translation> entry in _translations.entries) {
      // verify that all translations have same set of keys
      if (!setEquals(defaultLookupTable.keys.toSet(), entry.value.lookupTable.keys.toSet())) {
        logger.w("Translation keys does not match for ${entry.key} and ${Translator.instance.currentLanguage}!");
      }

      // verify that each translated string has same number of placeholders for same key
      for (MapEntry<String, String> lookupTable in entry.value.lookupTable.entries) {
        String defaultValue = defaultLookupTable[lookupTable.key]!;
        if (_numberOfPlaceholders(lookupTable.value) != _numberOfPlaceholders(defaultValue)) {
          logger.w("Translation values placeholders count mismatch: ${lookupTable.value} and $defaultValue!");
        }
      }
    }
  }

  /// Determines the number of placeholders in [raw] input String.
  int _numberOfPlaceholders(String raw) {
    return _placeholderRegex.allMatches(raw).length;
  }
}
