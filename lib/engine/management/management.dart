import 'package:incremental_ai/engine/management/clock.dart';
import 'package:incremental_ai/game/routine/routine_manager.dart';
import 'package:incremental_ai/game/supply/supply_manager.dart';
import 'package:incremental_ai/game/upgrade/upgrade_manager.dart';

class Management {
  final SupplyManager supplyManager = SupplyManager();
  final RoutineManager routineManager = RoutineManager();
  final UpgradeManager upgradeManager = UpgradeManager();
  late final Clock _updateDataClock;

  Management() {
    _updateDataClock = Clock(60, updateData);
  }

  Future<void> initialize() async {
    await supplyManager.initialize();
    await routineManager.initialize();

    upgradeManager.initialize();

    // start clock
    _updateDataClock.start();
  }

  void updateData(double deltaTime) {
    supplyManager.onUpdate(deltaTime);
    routineManager.onUpdate(deltaTime);
    upgradeManager.onUpdate(deltaTime);
  }
}
