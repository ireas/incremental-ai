import 'package:get_it/get_it.dart';
import 'package:incremental_ai/engine/archetype/repository/repository_archetype.dart';
import 'package:incremental_ai/engine/utility/has_update.dart';
import 'package:incremental_ai/engine/utility/has_validation.dart';
import 'package:incremental_ai/module/routine/model/processor/processor_model.dart';
import 'package:incremental_ai/module/routine/model/routine/base/routine_model.dart';
import 'package:incremental_ai/module/routine/model/routine/routine_type.dart';
import 'package:incremental_ai/module/routine/model/routine/variant/collect_scrap_routine.dart';

/// Repository for Routine module.
class RoutineRepository extends RepositoryArchetype with HasValidation, HasUpdate {
  /// Singleton instance.
  static RoutineRepository get instance => GetIt.I<RoutineRepository>();

  /// Routine models map that must contain all routines in the game.
  final Map<RoutineType, RoutineModel> _models = {};

  /// Singular processing model.
  final ProcessorModel processorModel = ProcessorModel();

  @override
  Future<void> initializeModels() async {
    _models[RoutineType.scrapDrones] = CollectScrapRoutine();
  }

  @override
  void validate() {
    for (RoutineType type in RoutineType.values) {
      if (!_models.containsKey(type)) {
        logger.e("No model defined for $type");
      }
    }
  }

  @override
  void update(double deltaTime) {
    for (RoutineModel model in _models.values) {
      model.update(deltaTime);
    }
    notifyListeners();
  }

  /// Fetches a [RoutineModel] that is identified by its [type].
  /// If no entry is found, returns [NULL].
  RoutineModel fetch(RoutineType type) {
    return _models[type] ?? (throw StateError('No model found for $type'));
  }

  /// Fetches all models in [_models] map and returns them as list.
  List<RoutineModel> fetchAll() {
    return _models.values.toList();
  }
}
