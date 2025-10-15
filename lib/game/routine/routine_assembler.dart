import 'package:get_it/get_it.dart';
import 'package:incremental_ai/engine/module/assembly.dart';
import 'package:incremental_ai/engine/module/module_assembler.dart';
import 'package:incremental_ai/game/routine/action/routine_processor_actions.dart';
import 'package:incremental_ai/game/routine/action/routine_level_actions.dart';
import 'package:incremental_ai/game/routine/action/routine_state_actions.dart';
import 'package:incremental_ai/game/routine/routine_repository.dart';

/// Assembler for routine module.
class RoutineAssembler extends ModuleAssembler {
  @override
  Future<void> assemble(Assembly assembler) async {
    // repository
    RoutineRepository repository = RoutineRepository();
    repository.initializeModels();
    GetIt.I.registerSingleton<RoutineRepository>(repository);
    assembler.registry.add(repository);

    // actions
    GetIt.I.registerSingleton<RoutineLevelActions>(RoutineLevelActions(repository));
    GetIt.I.registerSingleton<RoutineStateActions>(RoutineStateActions(repository));
    GetIt.I.registerSingleton<RoutineProcessorActions>(RoutineProcessorActions(repository));
  }
}
