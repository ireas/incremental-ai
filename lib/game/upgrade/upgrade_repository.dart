import 'package:get_it/get_it.dart';
import 'package:incremental_ai/engine/module/module_repository.dart';
import 'package:incremental_ai/game/upgrade/model/upgrade/base/upgrade_model.dart';
import 'package:incremental_ai/game/upgrade/model/upgrade/upgrade_type.dart';
import 'package:incremental_ai/game/upgrade/model/upgrade/variant/scrap_capacity_upgrade.dart';
import 'package:incremental_ai/game/upgrade/model/upgrade/variant/scrap_multi_capacity_upgrade.dart';

/// Repository for Upgrade module.
class UpgradeRepository extends ModuleRepository {
  /// Singleton served via [GetIt].
  static UpgradeRepository get instance => GetIt.I<UpgradeRepository>();

  /// All models mapped by their type.
  final Map<UpgradeType, UpgradeModel> _models = {};

  @override
  Future<void> initializeModels() async {
    _models[UpgradeType.increaseScrapCapacity] = ScrapCapacityUpgrade();
    _models[UpgradeType.increaseMultiScrapCapacity] = ScrapMultiCapacityUpgrade();
  }

  @override
  void validate() {
    for (UpgradeType type in UpgradeType.values) {
      if (!_models.containsKey(type)) {
        logger.e("No model defined for $type");
      }
    }
  }

  @override
  void update(double deltaTime) {
    for (UpgradeModel model in _models.values) {
      model.update();
    }
    notifyListeners();
  }

  /// Fetches the model corresponding to [type] from [_models].
  /// If no model is defined for type, throws [StateError].
  UpgradeModel fetch(UpgradeType type) {
    return _models[type] ?? (throw StateError('No model found for $type'));
  }

  /// Fetches all models in [_models] map and returns them as list.
  List<UpgradeModel> fetchAll() {
    return _models.values.toList();
  }
}
