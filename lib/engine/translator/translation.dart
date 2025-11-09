import 'enum/language.dart';

/// Data that holds a translation lookup table and its corresponding language.
class Translation {
  /// Language that this translation is for.
  final Language language;

  /// Translation lookup table that contains technical lookup keys and its translated text values.
  final Map<String, String> lookupTable;

  /// Constructor.
  Translation({required this.language, required this.lookupTable});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Translation &&
          runtimeType == other.runtimeType &&
          language == other.language &&
          lookupTable == other.lookupTable;

  @override
  int get hashCode => Object.hash(language, lookupTable);
}
