import 'package:get_it/get_it.dart';
import 'package:incremental_ai/engine/management/manager.dart';
import 'package:incremental_ai/game/routine/model/routine_model.dart';
import 'package:incremental_ai/game/routine/model/variants/scrap_routine.dart';
import 'package:logger/logger.dart';

class RoutineManager extends Manager {
  static final Logger _logger = Logger();
  late final Map<String, RoutineModel> models;

  RoutineManager() {
    GetIt.I.registerSingleton<RoutineManager>(this);
  }

  @override
  Future<void> initialize() async {
    // initialize models
    models = {};
    models["routine.scrap"] = ScrapRoutine(id: "routine.scrap");
    models["routine.scrap"]?.enabled = true;

  }

  @override
  void onUpdate(double deltaTime) {
    for (RoutineModel model in models.values) {
      model.update(deltaTime);
    }
  }

  void increment(String id) {
    _logger.t("Increment $id");
    RoutineModel? model = models[id];

    if (model == null) {
      _logger.w("$id mot found");
      return;
    }

    model.level += 1;
  }

  void decrement(String id) {
    _logger.t("Decrement $id");
    RoutineModel? model = models[id];

    if (model == null) {
      _logger.w("$id mot found");
      return;
    }

    model.level -= 1;
  }
}
