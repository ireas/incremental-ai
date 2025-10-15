import 'package:get_it/get_it.dart';
import 'package:incremental_ai/engine/module/module_usecase.dart';
import 'package:incremental_ai/game/routine/action/routine_processor_actions.dart';
import 'package:incremental_ai/game/routine/model/routine/routine_model.dart';
import 'package:incremental_ai/game/routine/routine_repository.dart';

/// Actions regarding routine level.
class RoutineLevelActions extends ModuleUsecase {
  /// Singleton instances served by [GetIt].
  static RoutineLevelActions get instance => GetIt.I<RoutineLevelActions>();

  /// Model repository.
  final RoutineRepository _repository;

  /// Constructor.
  RoutineLevelActions(this._repository);

  /// Fetches current level of routine specified by [id].
  int level(String id) {
    RoutineModel? model = _repository.fetch(id);
    if (model == null) {
      return 0;
    }
    return model.level;
  }

  /// Increments activation level of routine specified by [id] if sufficient processors are available.
  void increment(String id) {
    logger.t("Increment: $id");
    RoutineModel? routine = _repository.fetch(id);
    if (routine == null) {
      return;
    }

    // increment only if sufficient processors are available
    if (GetIt.I<RoutineProcessorActions>().sufficient(routine.processingCost)) {
      GetIt.I<RoutineProcessorActions>().addProcessorValue(-routine.processingCost);
      routine.level += 1;
    }
  }

  /// Decrements activation level of routine specified by [id] an release processors.
  void decrement(String id) {
    logger.t("Decrement: $id");
    RoutineModel? routine = _repository.fetch(id);
    if (routine == null) {
      return;
    }

    // decrement only if there is at least one level of routine
    if (routine.level > 0) {
      GetIt.I<RoutineProcessorActions>().addProcessorValue(routine.processingCost);
      routine.level -= 1;
    }
  }
}
