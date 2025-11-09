import 'package:get_it/get_it.dart';
import 'package:incremental_ai/engine/archetype/repository/repository_archetype.dart';
import 'package:incremental_ai/engine/utility/has_update.dart';
import 'package:incremental_ai/engine/utility/has_validation.dart';
import 'package:incremental_ai/module/supply/model/supply/base/supply_model.dart';
import 'package:incremental_ai/module/supply/model/supply/supply_type.dart';
import 'package:incremental_ai/module/supply/model/supply/variant/mana_supply_model.dart';
import 'package:incremental_ai/module/supply/model/supply/variant/scrap_supply_model.dart';

/// Repository class for Supply module.
class SupplyRepository extends RepositoryArchetype with HasValidation, HasUpdate {
  /// Singleton instance.
  static SupplyRepository get instance => GetIt.I<SupplyRepository>();

  /// All models mapped by their type.
  final Map<SupplyType, SupplyModel> _models = {};

  @override
  Future<void> initializeModels() async {
    _models[SupplyType.mana] = ManaSupplyModel();
    _models[SupplyType.scrap] = ScrapSupplyModel();
  }

  @override
  void validate() {
    for (SupplyType type in SupplyType.values) {
      if (!_models.containsKey(type)) {
        logger.e("No model defined for $type");
      }
    }
  }

  @override
  void update(double deltaTime) {
    for (SupplyModel model in _models.values) {
      model.update(deltaTime);
    }
    notifyListeners();
  }

  /// Fetches the model corresponding to [type] from [_models].
  /// If no model is defined for type, throws [StateError].
  SupplyModel fetch(SupplyType type) {
    return _models[type] ?? (throw StateError('No model found for $type'));
  }

  /// Fetches all models in [_models] map and returns them as list.
  List<SupplyModel> fetchAll() {
    return _models.values.toList();
  }
}
