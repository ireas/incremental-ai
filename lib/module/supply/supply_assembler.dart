import 'package:get_it/get_it.dart';
import 'package:incremental_ai/engine/archetype/assembler/assembler_archetype.dart';
import 'package:incremental_ai/engine/archetype/assembler/supports_action.dart';
import 'package:incremental_ai/engine/archetype/assembler/supports_repository.dart';
import 'package:incremental_ai/engine/utility/has_update.dart';
import 'package:incremental_ai/engine/utility/has_validation.dart';
import 'package:incremental_ai/module/supply/action/supply_amount_actions.dart';
import 'package:incremental_ai/module/supply/action/supply_capacity_actions.dart';
import 'package:incremental_ai/module/supply/action/supply_label_actions.dart';
import 'package:incremental_ai/module/supply/action/supply_state_actions.dart';
import 'package:incremental_ai/module/supply/supply_repository.dart';

/// Assembler for the Supply module.
class SupplyAssembler extends AssemblerArchetype
    with SupportsRepository, SupportsAction, HasValidation, HasUpdate {
  @override
  Future<void> assembleRepositories() async {
    SupplyRepository repository = SupplyRepository();
    await repository.initializeModels();
    GetIt.I.registerSingleton<SupplyRepository>(repository);
  }

  @override
  Future<void> assembleActions() async {
    GetIt.I.registerSingleton<SupplyAmountActions>(SupplyAmountActions());
    GetIt.I.registerSingleton<SupplyCapacityActions>(SupplyCapacityActions());
    GetIt.I.registerSingleton<SupplyStateActions>(SupplyStateActions());
    GetIt.I.registerSingleton<SupplyLabelActions>(SupplyLabelActions());
  }

  @override
  void validate() {
    SupplyRepository.instance.validate();
  }

  @override
  void update(double deltaTime) {
    SupplyRepository.instance.update(deltaTime);
  }
}
