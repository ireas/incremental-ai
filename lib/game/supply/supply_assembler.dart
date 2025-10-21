import 'package:get_it/get_it.dart';
import 'package:incremental_ai/engine/module/assembly.dart';
import 'package:incremental_ai/engine/module/module_assembler.dart';
import 'package:incremental_ai/game/supply/action/supply_capacity_actions.dart';
import 'package:incremental_ai/game/supply/action/supply_value_actions.dart';
import 'package:incremental_ai/game/supply/supply_repository.dart';
import 'package:incremental_ai/game/supply/usecase/supply_inspect_usecase.dart';
import 'package:incremental_ai/game/supply/usecase/supply_modify_usecase.dart';

class SupplyAssembler extends ModuleAssembler {
  @override
  Future<void> assemble(Assembly assembler) async {
    // repository
    SupplyRepository repository = SupplyRepository();
    repository.initializeModels();
    GetIt.I.registerSingleton<SupplyRepository>(repository);
    assembler.registry.add(repository);

    // usecases
    GetIt.I.registerSingleton<SupplyModifyUsecase>(SupplyModifyUsecase(repository));
    GetIt.I.registerSingleton<SupplyInspectUsecase>(SupplyInspectUsecase(repository));

    // actions
    GetIt.I.registerSingleton<SupplyValueActions>(SupplyValueActions(repository));
    GetIt.I.registerSingleton<SupplyCapacityActions>(SupplyCapacityActions(repository));
  }
}
