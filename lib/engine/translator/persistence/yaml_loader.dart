import 'package:flutter/services.dart';
import 'package:incremental_ai/engine/utility/loggable.dart';
import 'package:yaml/yaml.dart';

/// Loader class that targets a valid [assetPath] and loads [YamlMap] or dart [Map] from asset file.
class YamlLoader with Loggable {
  /// Path to .yaml file in assets directory.
  final String assetPath;

  /// Constructor.
  YamlLoader({required this.assetPath});

  /// Loads a [YamlMap] from target [assetPath].
  Future<YamlMap> loadYamlMap() async {
    logger.t("Loading YamlMap...");
    String raw = await rootBundle.loadString(assetPath);
    return loadYaml(raw) as YamlMap;
  }

  /// Loads a flat dart [Map] from target [assetPath].
  Future<Map<String, String>> loadFlatDartMap() async {
    YamlMap yamlMap = await loadYamlMap();
    logger.t("Flattening YamlMap to plain Map...");
    return _flattenYamlMap(yamlMap);
  }

  /// Recursively flatten the given [yamlMap] to a dart [Map].
  /// This flat map will contain all values exactly what a properties file would look like.
  ///
  /// The [YamlMap] can only contain additional [String], [YamlMap] or [YamlScalar].
  /// The [prefix] parameter tracks the current path within the YAML structure.
  Map<String, String> _flattenYamlMap(YamlMap yamlMap, {String prefix = ""}) {
    // construct empty dart map
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
        logger.w("Skipping node that could not be parsed: $node");
      }
    }

    return flatMap;
  }
}
