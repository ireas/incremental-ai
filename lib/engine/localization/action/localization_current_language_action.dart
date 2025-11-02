import 'package:get_it/get_it.dart';
import 'package:incremental_ai/engine/localization/language.dart';
import 'package:incremental_ai/engine/localization/localization_repository.dart';
import 'package:logger/logger.dart';

/// Usecase for reading and modifying currently active language
class LocalizationCurrentLanguageAction {
  static LocalizationCurrentLanguageAction get instance => GetIt.I<LocalizationCurrentLanguageAction>();
  final Logger _logger = Logger();

  /// Fetches the currently active language from repository.
  Language getCurrentLanguage() {
    return LocalizationRepository.instance.currentLanguage;
  }

  /// Updates the currently active language in repository to input [language].
  void updateCurrentLanguage(Language language) {
    _logger.t("Switching active language to $language");
    _logger.e("Switching language is currently not properly implemented and should not be used!");
    LocalizationRepository.instance.currentLanguage = language;
  }
}
