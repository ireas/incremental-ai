import 'package:incremental_ai/engine/module/module_usecase.dart';
import 'package:incremental_ai/game/routine/enum/routine_state.dart';
import 'package:incremental_ai/game/routine/enum/routine_type.dart';
import 'package:incremental_ai/game/routine/routine_repository.dart';

class RoutineModifyUsecase extends ModuleUsecase {
  final RoutineRepository repository;

  RoutineModifyUsecase(this.repository);

  /// Enables a routine model, targets model with set [type].
  void enable(RoutineType type) {
    logger.t("Enable: $type");
    repository.fetch(type)?.state = RoutineState.unlocked;
  }

  /// Increments a routine level, targets [type].
  void increment(RoutineType type) {
    logger.t("Increment: $type");
    repository.fetch(type)?.level += 1;
  }

  /// Decrements a routine level, targets [type].
  void decrement(RoutineType type) {
    logger.t("Decrement: $type");
    repository.fetch(type)?.level -= 1;
  }
}
