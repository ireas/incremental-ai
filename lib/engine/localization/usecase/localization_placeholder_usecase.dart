import 'package:incremental_ai/engine/localization/localization_repository.dart';
import 'package:logger/logger.dart';

/// Usecase for replacing placeholders in localized strings.
class LocalizationPlaceholderUsecase {
  static final Logger _logger = Logger();
  static final RegExp _placeholderRegex = RegExp(r'{.*?}');
  final LocalizationRepository repository;

  LocalizationPlaceholderUsecase(this.repository);

  /// Replaces the placeholders in [raw] String by injecting the [replacements].
  /// The placeholders in [raw] must match the keys in [replacements] and must be contained in curly brackets.
  /// There should not be more replacements values than placeholder.
  ///
  /// Example:
  /// The placeholder "{targetValue}" in [raw] would be replaced by the [replacements] entry with key "targetValue".
  String replacePlaceholders(String raw, Map<String, String> replacements) {
    // copy raw value for replacing
    String refined = raw.toString();

    // replace each string in refined string
    for (MapEntry<String, String> replacement in replacements.entries) {
      if (!refined.toLowerCase().contains("{${replacement.key.toLowerCase()}}")) {
        _logger.w("Could not find ${replacement.key} placeholder in raw");
        return raw;
      }

      _logger.t("Replace ${replacement.key} with ${replacement.value} in $refined");
      refined = refined.replaceAll(RegExp("{${replacement.key}}", caseSensitive: false), replacement.value);
    }

    // return replaced string
    return refined;
  }

  /// Determines the number of placeholders in the [raw] input String.
  int numberOfPlaceholders(String raw) {
    return _placeholderRegex.allMatches(raw).length;
  }
}
