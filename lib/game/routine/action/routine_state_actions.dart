import 'package:get_it/get_it.dart';
import 'package:incremental_ai/engine/module/module_usecase.dart';
import 'package:incremental_ai/game/routine/model/enum/routine_state.dart';
import 'package:incremental_ai/game/routine/routine_repository.dart';

/// Actions regarding routine states.
class RoutineStateActions extends ModuleUsecase {
  /// Singleton instances served by [GetIt].
  static RoutineStateActions get instance => GetIt.I<RoutineStateActions>();

  /// Model repository.
  final RoutineRepository _repository;

  /// Constructor.
  RoutineStateActions(this._repository);

  /// Enables a routine model, targets model with specified [id].
  void enable(String id) {
    logger.t("Enable: $id");
    _repository.fetch(id)?.state = RoutineState.unlocked;
  }
}
