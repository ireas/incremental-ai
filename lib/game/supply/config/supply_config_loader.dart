import 'package:incremental_ai/engine/yaml_reader.dart';
import 'package:incremental_ai/game/supply/config/enum/supply_id.dart';
import 'package:incremental_ai/game/supply/config/supply_config.dart';
import 'package:incremental_ai/game/supply/config/supply_config_entry.dart';
import 'package:logger/logger.dart';
import 'package:yaml/yaml.dart';

class SupplyConfigLoader {
  final Logger _logger = Logger();

  SupplyConfigLoader();

  Future<SupplyConfig> load() async {
    Map<String, dynamic> loadedValue = await YamlReader.load("assets/supplies.yaml", "");
    YamlList yamlList = loadedValue["supplies"] as YamlList;

    Map<String, SupplyConfigEntry> protoMap = {};

    try {
      for (dynamic entry in yamlList) {
        if (entry is! YamlMap) {
          continue;
        }
        SupplyConfigEntry supplyConfigEntry = SupplyConfigEntry.fromMap(entry as Map<String, dynamic>);
        protoMap[supplyConfigEntry.id] = supplyConfigEntry;
        _logger.t("${supplyConfigEntry.id}: $supplyConfigEntry");
      }
    } catch (ex) {
      _logger.e("Could not parse supply configuration!");
    }

    SupplyConfig config = SupplyConfig(protoMap);
    validate(config);

    return config;
  }

  bool validate(SupplyConfig config) {
    bool validated = true;

    for (final supplyId in SupplyId.values) {
      if (!config.map.containsKey(supplyId.name)) {
        _logger.w("${supplyId.name} not found in supply configuration!");
        validated = false;
      }
    }

    for (final supplyId in config.map.keys) {
      if (SupplyIdExtention.from(supplyId) == null) {
        _logger.w("$supplyId not defined in supply id enum!");
        validated = false;
      }
    }

    return validated;
  }
}
