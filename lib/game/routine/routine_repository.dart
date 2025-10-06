import 'package:incremental_ai/engine/module/module_repository.dart';
import 'package:incremental_ai/game/routine/enum/routine_type.dart';
import 'package:incremental_ai/game/routine/model/routine_model.dart';
import 'package:incremental_ai/game/routine/model/variant/scrap_routine.dart';

class RoutineRepository extends ModuleRepository {
  final Map<RoutineType, RoutineModel> models = {};

  @override
  Future<void> initializeModels() async {
    // initialize models
    models[RoutineType.collectScrap] = CollectScrapRoutine();
  }

  @override
  void update(double deltaTime) {
    for (RoutineModel model in models.values) {
      model.update(deltaTime);
    }
  }

  /// Fetches a [RoutineModel] that is identified by its [RoutineType].
  /// If no entry is found, returns [NULL].
  RoutineModel? fetch(RoutineType type) {
    RoutineModel? model = models[type];
    if (model == null) {
      logger.w("No model found for $type");
    }
    return model;
  }
}
