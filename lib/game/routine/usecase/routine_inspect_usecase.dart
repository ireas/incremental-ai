import 'package:incremental_ai/engine/module/module_usecase.dart';
import 'package:incremental_ai/game/routine/enum/routine_type.dart';
import 'package:incremental_ai/game/routine/model/routine_model.dart';
import 'package:incremental_ai/game/routine/routine_repository.dart';

class RoutineInspectUsecase extends ModuleUsecase {
  final RoutineRepository repository;

  RoutineInspectUsecase(this.repository);

  /// Fetches current level of target Routine [type].
  int level(RoutineType type) {
    RoutineModel? model = repository.fetch(type);
    if (model == null) {
      return 0;
    }
    return model.level;
  }
}
