import 'package:incremental_ai/engine/module/clock.dart';
import 'package:incremental_ai/engine/module/module_repository.dart';
import 'package:incremental_ai/game/quest/quest_assembler.dart';
import 'package:incremental_ai/game/routine/routine_assembler.dart';
import 'package:incremental_ai/game/supply/supply_assembler.dart';
import 'package:incremental_ai/game/upgrade/upgrade_assembler.dart';

class Assembly {
  late final Clock _updateDataClock;
  final List<ModuleRepository> registry = [];

  Assembly() {
    _updateDataClock = Clock(60, updateData);
  }

  Future<void> assemble() async {
    await SupplyAssembler().assemble(this);
    await RoutineAssembler().assemble(this);
    await QuestAssembler().assemble(this);
    await UpgradeAssembler().assemble(this);

    // start clock
    _updateDataClock.start();
  }

  void updateData(double deltaTime) {
    for (var element in registry) {
      element.update(deltaTime);
    }
  }
}
