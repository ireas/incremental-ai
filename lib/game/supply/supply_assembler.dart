import 'package:get_it/get_it.dart';
import 'package:incremental_ai/engine/module/assembly.dart';
import 'package:incremental_ai/engine/module/module_assembler.dart';
import 'package:incremental_ai/game/supply/action/supply_amount_actions.dart';
import 'package:incremental_ai/game/supply/action/supply_capacity_actions.dart';
import 'package:incremental_ai/game/supply/action/supply_label_actions.dart';
import 'package:incremental_ai/game/supply/action/supply_state_actions.dart';
import 'package:incremental_ai/game/supply/supply_repository.dart';

/// Assembler for the Supply module.
class SupplyAssembler extends ModuleAssembler {
  @override
  Future<void> assemble(Assembly assembler) async {
    // repository
    SupplyRepository repository = SupplyRepository();
    await repository.initializeModels();
    repository.validate();
    GetIt.I.registerSingleton<SupplyRepository>(repository);
    assembler.registry.add(repository);

    // actions
    GetIt.I.registerSingleton<SupplyAmountActions>(SupplyAmountActions());
    GetIt.I.registerSingleton<SupplyCapacityActions>(SupplyCapacityActions());
    GetIt.I.registerSingleton<SupplyStateActions>(SupplyStateActions());
    GetIt.I.registerSingleton<SupplyLabelActions>(SupplyLabelActions());
  }
}
