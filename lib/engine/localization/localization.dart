import 'language.dart';

/// A localization is a data that holds a translation lookup table that corresponds to a specific language.
/// The lookup table contains lookup keys that must be equal for all localizations and translated string values.
class Localization {
  final Language language;
  final Map<String, String> lookupTable;

  Localization({required this.language, required this.lookupTable});
}
