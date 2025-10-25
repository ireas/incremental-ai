import 'package:get_it/get_it.dart';
import 'package:incremental_ai/engine/cycle/clock/clock.dart';
import 'package:incremental_ai/engine/cycle/preload/cycle_preloader.dart';
import 'package:incremental_ai/engine/module/module_repository.dart';
import 'package:incremental_ai/game/quest/quest_assembler.dart';
import 'package:incremental_ai/game/routine/routine_assembler.dart';
import 'package:incremental_ai/game/supply/supply_assembler.dart';
import 'package:incremental_ai/game/upgrade/upgrade_assembler.dart';

/// Assembly that executes all register assemblers, preloads game effects and starts game loop after assembly.
class Assembly {
  /// Game loop clock to update repositories.
  late final CycleClock _updateDataClock;

  /// Register of all module repositories to update.
  final List<ModuleRepository> registry = [];

  /// Constructor.
  Assembly() {
    _updateDataClock = CycleClock(60, updateData);
  }

  /// Assemble game modules, including preloading and game start afterwards.
  ///
  /// TODO: separate concerns of game loop (cycle) and game module assembling (assembly)
  /// TODO: consider making the game engine assembly a plugin-based class for easier maintenance
  Future<void> assemble() async {
    // provide a preloader
    GetIt.instance.registerSingleton<CyclePreloader>(CyclePreloader());

    // assemble all game modules
    await SupplyAssembler().assemble(this);
    await RoutineAssembler().assemble(this);
    await QuestAssembler().assemble(this);
    await UpgradeAssembler().assemble(this);

    // execute preloading
    CyclePreloader.instance.preload();

    // start game loop clock
    _updateDataClock.start();
  }

  /// Method to invoke regularly that updates all repositories in registry.
  void updateData(double deltaTime) {
    for (var element in registry) {
      element.update(deltaTime);
    }
  }
}
