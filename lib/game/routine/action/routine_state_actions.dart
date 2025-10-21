import 'package:get_it/get_it.dart';
import 'package:incremental_ai/engine/module/module_usecase.dart';
import 'package:incremental_ai/game/routine/model/routine/routine_state.dart';
import 'package:incremental_ai/game/routine/model/routine/routine_type.dart';
import 'package:incremental_ai/game/routine/routine_repository.dart';

/// Actions regarding routine states.
class RoutineStateActions extends ModuleActions {
  /// Singleton instances served by [GetIt].
  static RoutineStateActions get instance => GetIt.I<RoutineStateActions>();

  /// Enables a routine model, targets model with specified [type].
  void unlock(RoutineType type) {
    logger.t("Enable: $type");
    RoutineRepository.instance.fetch(type).state = RoutineState.unlocked;
  }
}
