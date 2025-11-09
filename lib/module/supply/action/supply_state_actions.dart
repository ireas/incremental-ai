import 'package:get_it/get_it.dart';
import 'package:incremental_ai/engine/archetype/action/action_archetype.dart';
import 'package:incremental_ai/module/supply/model/supply/supply_state.dart';
import 'package:incremental_ai/module/supply/model/supply/supply_type.dart';
import 'package:incremental_ai/module/supply/supply_repository.dart';

/// Actions regarding supply capacities.
class SupplyStateActions extends ActionArchetype {
  /// Singleton instance.
  static SupplyStateActions get instance => GetIt.I<SupplyStateActions>();

  /// Enables a supply model, targets model with set [type].
  void unlock(SupplyType type) {
    logger.t("Enable: $type");
    SupplyRepository.instance.fetch(type).state = SupplyState.unlocked;
  }
}
