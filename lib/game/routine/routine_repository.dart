import 'package:incremental_ai/engine/module/module_repository.dart';
import 'package:incremental_ai/game/routine/model/processor/processor_model.dart';
import 'package:incremental_ai/game/routine/model/routine/routine_model.dart';
import 'package:incremental_ai/game/routine/model/routine/variant/collect_scrap_routine.dart';

/// Repository for routine module.
class RoutineRepository extends ModuleRepository {
  /// Routine models map that must contain all routines in the game.
  final Map<String, RoutineModel> models = {};

  /// Singular processing model
  final ProcessorModel processorModel = ProcessorModel();

  @override
  Future<void> initializeModels() async {
    // initialize models
    models[CollectScrapRoutine.sourceId] = CollectScrapRoutine();
  }

  @override
  void validate() {}

  @override
  void update(double deltaTime) {
    for (RoutineModel model in models.values) {
      model.update(deltaTime);
    }
  }

  /// Fetches a [RoutineModel] that is identified by its [id].
  /// If no entry is found, returns [NULL].
  RoutineModel? fetch(String id) {
    RoutineModel? model = models[id];
    if (model == null) {
      logger.w("No model found for $id");
    }
    return model;
  }
}
