import 'package:get_it/get_it.dart';
import 'package:incremental_ai/engine/translator/enum/language.dart';
import 'package:incremental_ai/engine/translator/persistence/yaml_loader.dart';
import 'package:incremental_ai/engine/translator/translation.dart';
import 'package:incremental_ai/engine/translator/translator_validator.dart';
import 'package:incremental_ai/engine/utility/loggable.dart';

/// Translation service that can be used to translate technical key into translated messages and replace placeholders in the translated messages.
class Translator with Loggable {
  /// Singleton instance.
  static Translator get instance => GetIt.I<Translator>();

  /// Currently active language.
  /// TODO: make this a context extensions so everything rebuilds on change
  Language currentLanguage = Language.english;

  /// Translation lookup tables mapped to their corresponding language.
  final Map<Language, Translation> _translations = {};

  /// Loads all translations for each language
  Future<void> init() async {
    GetIt.I.registerSingleton<Translator>(this);

    // load
    logger.t("Loading all translations.");
    await _addTranslation(Language.english, "assets/translation/en.yaml");
    await _addTranslation(Language.german, "assets/translation/de.yaml");

    // validate
    logger.t("Validate all translations.");
    TranslatorValidator(_translations).validate();
  }

  /// Loads a translation file from [assetPath] from YAML file and registers a translation for [language].
  Future<void> _addTranslation(Language language, String assetPath) async {
    logger.t("Loading translation for $language from $assetPath.");
    Map<String, String> lookupTable = await YamlLoader(assetPath: assetPath).loadFlatDartMap();
    _translations[language] = Translation(language: language, lookupTable: lookupTable);
  }

  /// Fetches the translation corresponding to [language] from [_translations].
  /// If no model is defined for type, throws [StateError].
  Translation fetchTranslation(Language language) {
    return _translations[language] ?? (throw StateError('No model found for $language'));
  }

  /// Translates a technical lookup [key] to the currently active language.
  /// If translation lookup fails, returns lookup [key].
  String translate(String key) {
    logger.t("Translating $key");

    // fetch currently active translation and translate key
    String? translatedString = fetchTranslation(currentLanguage).lookupTable[key];

    // check if entry is found
    if (translatedString == null) {
      logger.w("No entry found for $key using $currentLanguage");
      return key;
    }

    // return translated string
    logger.t("Translated $key to $translatedString");
    return translatedString;
  }

  /// Replaces the placeholders in [raw] String by injecting the [replacements].
  /// The placeholders in [raw] must match the keys in [replacements] and must be contained in curly brackets.
  /// There should not be more replacements values than placeholder.
  ///
  /// Example:
  /// The placeholder "{targetValue}" in [raw] would be replaced by the [replacements] entry with key "targetValue".
  String replace(String raw, Map<String, String> replacements) {
    // copy raw value for replacing
    String refined = raw.toString();

    // replace each string in refined string
    for (MapEntry<String, String> replacement in replacements.entries) {
      if (!refined.toLowerCase().contains("{${replacement.key.toLowerCase()}}")) {
        logger.w("Could not find ${replacement.key} placeholder in raw");
        return raw;
      }

      logger.t("Replace ${replacement.key} with ${replacement.value} in $refined");
      refined = refined.replaceAll(RegExp("{${replacement.key}}", caseSensitive: false), replacement.value);
    }

    // return replaced string
    return refined;
  }

  /// Translates a technical lookup [key] and replaces placeholders with values in [replacements].
  /// If translation lookup fails, returns lookup [key].
  String translateAndReplace(String key, Map<String, String> replacements) {
    String raw = translate(key);
    // if translation failed, skip replacement
    if (raw == key) {
      logger.t("Translation failed for $key, skipping replacement.");
      return key;
    }
    return replace(raw, replacements);
  }
}
