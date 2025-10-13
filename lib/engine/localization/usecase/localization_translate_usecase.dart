import 'package:get_it/get_it.dart';
import 'package:incremental_ai/engine/localization/localization.dart';
import 'package:incremental_ai/engine/localization/localization_repository.dart';
import 'package:incremental_ai/engine/localization/usecase/localization_placeholder_usecase.dart';
import 'package:logger/logger.dart';

/// Usecase for translating technical lookup keys into their localized Strings.
class LocalizationTranslateUsecase {
  final Logger _logger = Logger();
  final LocalizationRepository repository;

  LocalizationTranslateUsecase(this.repository);

  /// Translates a technical lookup [key] to its currently active language.
  /// If translation lookup fails, returns lookup [key]
  String translate(String key) {
    _logger.t("Translating $key");

    // fetch currently active localization
    Localization localization = repository.fetchCurrentLocalization();

    // get translated string
    String? translation = localization.lookupTable[key];

    // check if entry is found
    if (translation == null) {
      _logger.w("No entry found for $key using ${localization.language}");
      return key;
    }

    // return translated string
    _logger.t("Translated $key to $translation");
    return translation;
  }

  /// Translates a technical lookup [key] via [translate] and replaces placeholders with values in [replacements].
  /// If translation lookup fails, returns lookup [key]
  String translateAndReplace(String key, Map<String, String> replacements) {
    // try translating
    String raw = translate(key);

    // if translating fails, return raw key
    if (raw == key) {
      return key;
    }

    // replace placeholders if there are any
    _logger.t("Refining $raw");
    String refined = GetIt.I<LocalizationPlaceholderUsecase>().replacePlaceholders(raw, replacements);

    // return refined string
    _logger.t("Translated $key to $refined");
    return refined;
  }
}
