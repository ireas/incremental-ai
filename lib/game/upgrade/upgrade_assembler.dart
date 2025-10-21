import 'package:get_it/get_it.dart';
import 'package:incremental_ai/engine/module/assembly.dart';
import 'package:incremental_ai/engine/module/module_assembler.dart';
import 'package:incremental_ai/game/upgrade/action/upgrade_label_actions.dart';
import 'package:incremental_ai/game/upgrade/action/upgrade_state_actions.dart';
import 'package:incremental_ai/game/upgrade/upgrade_repository.dart';

/// Assembler for the Upgrade module.
class UpgradeAssembler extends ModuleAssembler {
  @override
  Future<void> assemble(Assembly assembler) async {
    // repository
    UpgradeRepository repository = UpgradeRepository();
    await repository.initializeModels();
    repository.validate();
    GetIt.I.registerSingleton<UpgradeRepository>(repository);
    assembler.registry.add(repository);

    // action
    GetIt.I.registerSingleton<UpgradeStateActions>(UpgradeStateActions());
    GetIt.I.registerSingleton<UpgradeLabelActions>(UpgradeLabelActions());
  }
}
