import 'package:get_it/get_it.dart';
import 'package:incremental_ai/engine/module/assembly.dart';
import 'package:incremental_ai/engine/module/module_assembler.dart';
import 'package:incremental_ai/game/upgrade/action/upgrade_label_action.dart';
import 'package:incremental_ai/game/upgrade/action/upgrade_state_action.dart';
import 'package:incremental_ai/game/upgrade/upgrade_repository.dart';

/// Assembler class for Upgrade module.
class UpgradeAssembler extends ModuleAssembler {
  @override
  Future<void> assemble(Assembly assembler) async {
    // repository
    UpgradeRepository repository = UpgradeRepository();
    repository.initializeModels();
    GetIt.I.registerSingleton<UpgradeRepository>(repository);
    assembler.registry.add(repository);

    // action
    GetIt.I.registerSingleton<UpgradeStateAction>(UpgradeStateAction());
    GetIt.I.registerSingleton<UpgradeLabelAction>(UpgradeLabelAction());
  }
}
