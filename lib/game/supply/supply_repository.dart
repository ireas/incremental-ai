import 'package:incremental_ai/engine/module/module_repository.dart';
import 'package:incremental_ai/game/supply/enum/supply_type.dart';
import 'package:incremental_ai/game/supply/model/supply_model.dart';
import 'package:incremental_ai/game/supply/model/variant/mana_supply_model.dart';
import 'package:incremental_ai/game/supply/model/variant/scrap_supply_model.dart';

/// Repository class for Supply module.
class SupplyRepository extends ModuleRepository {
  final Map<SupplyType, SupplyModel> models = {};

  @override
  Future<void> initializeModels() async {
    models[ManaSupplyModel.sourceType] = ManaSupplyModel();
    models[ScrapSupplyModel.sourceType] = ScrapSupplyModel();
  }

  @override
  void update(double deltaTime) {
    for (SupplyModel model in models.values) {
      model.update(deltaTime);
    }
  }

  @override
  void validate() {}

  /// Fetches a [SupplyModel] that is identified by its [SupplyType].
  /// If no entry is found, returns [NULL].
  SupplyModel fetch(SupplyType type) {
    SupplyModel? model = models[type];
    if (model == null) {
      logger.w("No model found for $type");
    }
    return model!;
  }
}
