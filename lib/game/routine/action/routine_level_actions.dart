import 'package:get_it/get_it.dart';
import 'package:incremental_ai/engine/module/module_usecase.dart';
import 'package:incremental_ai/game/routine/action/routine_processor_actions.dart';
import 'package:incremental_ai/game/routine/model/routine/base/routine_model.dart';
import 'package:incremental_ai/game/routine/model/routine/routine_type.dart';
import 'package:incremental_ai/game/routine/routine_repository.dart';

/// Actions regarding routine level.
class RoutineLevelActions extends ModuleActions {
  /// Singleton instances served by [GetIt].
  static RoutineLevelActions get instance => GetIt.I<RoutineLevelActions>();

  /// Fetches current level of routine specified by [type].
  int level(RoutineType type) {
    return RoutineRepository.instance.fetch(type).level;
  }

  /// Increments activation level of routine specified by [type] if sufficient processors are available.
  void increment(RoutineType type) {
    logger.t("Increment: $type");
    RoutineModel routine = RoutineRepository.instance.fetch(type);

    // increment only if sufficient processors are available
    if (RoutineProcessorActions.instance.sufficient(routine.processingCost)) {
      RoutineProcessorActions.instance.addProcessorValue(-routine.processingCost);
      routine.level += 1;
    }
  }

  /// Decrements activation level of routine specified by [type] an release processors.
  void decrement(RoutineType type) {
    logger.t("Decrement: $type");
    RoutineModel routine = RoutineRepository.instance.fetch(type);

    // decrement only if there is at least one level of routine
    if (routine.level > 0) {
      RoutineProcessorActions.instance.addProcessorValue(routine.processingCost);
      routine.level -= 1;
    }
  }
}
