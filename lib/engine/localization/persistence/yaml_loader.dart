import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:yaml/yaml.dart';

/// A loader class that needs to target a valid [_assetPath] and then can load [YamlMap] or dart [Map] from asset.
class YamlLoader {
  final Logger _logger = Logger();
  final String _assetPath;

  YamlLoader(this._assetPath);

  /// Loads a [YamlMap] from target [_assetPath].
  Future<YamlMap> loadYamlMap() async {
    _logger.t("Loading YAML map...");
    String raw = await rootBundle.loadString(_assetPath);
    return loadYaml(raw) as YamlMap;
  }

  /// Loads a flat dart [Map] from target [_assetPath].
  Future<Map<String, String>> loadFlatDartMap() async {
    YamlMap yamlMap = await loadYamlMap();
    _logger.t("Flattening YAML map...");
    return _flattenYamlMap(yamlMap);
  }

  /// Recursively flatten the given [yamlMap] to a dart [Map].
  /// This flat map will contain all values exactly what a properties file would look like.
  ///
  /// The [YamlMap] can only contain additional [String], [YamlMap] or [YamlScalar].
  /// The [prefix] parameter tracks the current path within the YAML structure.
  Map<String, String> _flattenYamlMap(YamlMap yamlMap, {String prefix = ""}) {
    Map<String, String> flatMap = {};

    // convert dynamic keys to string
    for (String key in yamlMap.keys.map((yamlKey) => yamlKey.toString())) {
      dynamic node = yamlMap[key];
      String prefixedKey = "$prefix$key";
      if (node is String) {
        flatMap[prefixedKey] = node;
      } else if (node is YamlScalar) {
        flatMap[prefixedKey] = node.value.toString();
      } else if (node is YamlMap) {
        flatMap.addAll(_flattenYamlMap(node, prefix: "$prefixedKey."));
      } else {
        _logger.w("Skipping node that could not be parsed: $node");
      }
    }

    return flatMap;
  }
}
