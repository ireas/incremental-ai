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
  /// If any [replacements] are given, also replaces the placeholders in String.
  /// If translation lookup fails, return key
  String translate(String key, {Map<String, String>? replacements}) {
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

    // replace placeholders if there are any
    translation = GetIt.I<LocalizationPlaceholderUsecase>().replacePlaceholders(translation, replacements ?? {});

    // return translated string
    _logger.t("Translated $key to $translation");
    return translation;
  }
}
