import 'package:get_it/get_it.dart';
import 'package:incremental_ai/engine/archetype/assembler/assembler_archetype.dart';
import 'package:incremental_ai/engine/archetype/assembler/supports_action.dart';
import 'package:incremental_ai/engine/archetype/assembler/supports_repository.dart';
import 'package:incremental_ai/engine/utility/has_update.dart';
import 'package:incremental_ai/engine/utility/has_validation.dart';
import 'package:incremental_ai/module/upgrade/action/upgrade_label_actions.dart';
import 'package:incremental_ai/module/upgrade/action/upgrade_state_actions.dart';
import 'package:incremental_ai/module/upgrade/upgrade_repository.dart';

/// Assembler for the Upgrade module.
class UpgradeAssembler extends AssemblerArchetype
    with SupportsRepository, SupportsAction, HasValidation, HasUpdate {
  @override
  Future<void> assembleRepositories() async {
    UpgradeRepository repository = UpgradeRepository();
    await repository.initializeModels();
    GetIt.I.registerSingleton<UpgradeRepository>(repository);
  }

  @override
  Future<void> assembleActions() async {
    GetIt.I.registerSingleton<UpgradeStateActions>(UpgradeStateActions());
    GetIt.I.registerSingleton<UpgradeLabelActions>(UpgradeLabelActions());
  }

  @override
  void validate() {
    UpgradeRepository.instance.validate();
  }

  @override
  void update(double deltaTime) {
    UpgradeRepository.instance.update(deltaTime);
  }
}
