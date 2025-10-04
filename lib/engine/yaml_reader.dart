import 'package:flutter/services.dart';
import 'package:yaml/yaml.dart';

abstract class YamlReader {
  static Future<Map<String, dynamic>> load(String filePath, String root) async {
    final String yamlString = await rootBundle.loadString(filePath);
    final YamlMap data = loadYaml(yamlString) as YamlMap;

    Map<String, dynamic> mapped = {};
    for (MapEntry<dynamic, dynamic> yamlEntry in data.entries) {
      mapped[yamlEntry.key.toString()] = yamlEntry.value;
    }

    return mapped;
  }
}
