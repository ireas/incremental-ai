import 'package:incremental_ai/engine/module/module_usecase.dart';
import 'package:incremental_ai/game/supply/enum/supply_state.dart';
import 'package:incremental_ai/game/supply/enum/supply_type.dart';
import 'package:incremental_ai/game/supply/supply_repository.dart';

class SupplyModifyUsecase extends ModuleUsecase {
  final SupplyRepository repository;

  SupplyModifyUsecase(this.repository);

  /// Enables a supply model, targets model with set [type].
  void enable(SupplyType type) {
    logger.t("Enable: $type");
    repository.fetch(type)?.state = SupplyState.unlocked;
  }

  /// increases a models value by given input [value] parameter, targets model with set [type].
  void increaseValue(SupplyType type, double value) {
    logger.t("Increase Value: $type");
    repository.fetch(type)?.value += value;
  }
}
