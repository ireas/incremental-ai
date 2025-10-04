import 'package:incremental_ai/game/supply/config/supply_config_entry.dart';

class SupplyConfig {
  final Map<String, SupplyConfigEntry> map;

  SupplyConfig(this.map);

  @override
  String toString() {
    return "$runtimeType (${map.length} entries)";
  }
}
