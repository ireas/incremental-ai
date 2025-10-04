import 'package:get_it/get_it.dart';
import 'package:incremental_ai/engine/management/manager.dart';
import 'package:incremental_ai/game/upgrade/model/upgrade_model.dart';
import 'package:logger/logger.dart';

class UpgradeManager extends Manager {
  static final Logger _logger = Logger();
  final Map<String, UpgradeModel> models = {};

  UpgradeManager() {
    GetIt.I.registerSingleton<UpgradeManager>(this);
  }

  @override
  Future<void> initialize() async {
    // initialize models
    UpgradeModel upgrade1 = UpgradeModel(id: "upgrade.first");
    models[upgrade1.id] = upgrade1;
  }

  void enable(String id) {
    _logger.w("Enabling $id");
    UpgradeModel? model = models[id];

    if (model == null) {
      _logger.w("$id mot found");
      return;
    }

    model.enabled = true;
  }

  @override
  void onUpdate(double deltaTime) {
    for (UpgradeModel model in models.values) {
      model.update(deltaTime);
    }
  }
}
