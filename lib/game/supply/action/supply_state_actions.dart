import 'package:get_it/get_it.dart';
import 'package:incremental_ai/engine/module/module_usecase.dart';
import 'package:incremental_ai/game/supply/model/supply/supply_state.dart';
import 'package:incremental_ai/game/supply/model/supply/supply_type.dart';
import 'package:incremental_ai/game/supply/supply_repository.dart';

/// Actions regarding supply capacities.
class SupplyStateActions extends ModuleActions {
  /// Singleton instance served by [GetIt].
  static SupplyStateActions get instance => GetIt.I<SupplyStateActions>();

  /// Enables a supply model, targets model with set [type].
  void unlock(SupplyType type) {
    logger.t("Enable: $type");
    SupplyRepository.instance.fetch(type).state = SupplyState.unlocked;
  }
}
