import 'package:get_it/get_it.dart';
import 'package:incremental_ai/engine/archetype/assembler/assembler_archetype.dart';
import 'package:incremental_ai/engine/archetype/assembler/supports_action.dart';
import 'package:incremental_ai/engine/archetype/assembler/supports_post_assemble.dart';
import 'package:incremental_ai/engine/archetype/assembler/supports_repository.dart';
import 'package:incremental_ai/engine/utility/has_update.dart';
import 'package:incremental_ai/engine/utility/has_validation.dart';
import 'package:incremental_ai/module/routine/action/routine_level_actions.dart';
import 'package:incremental_ai/module/routine/action/routine_processor_actions.dart';
import 'package:incremental_ai/module/routine/action/routine_state_actions.dart';
import 'package:incremental_ai/module/routine/routine_repository.dart';

/// Assembler for the Routine module.
class RoutineAssembler extends AssemblerArchetype
    with SupportsRepository, SupportsAction, SupportsPostAssemble, HasValidation, HasUpdate {
  @override
  Future<void> assembleRepositories() async {
    RoutineRepository repository = RoutineRepository();
    await repository.initializeModels();
    GetIt.I.registerSingleton<RoutineRepository>(repository);
  }

  @override
  Future<void> assembleActions() async {
    GetIt.I.registerSingleton<RoutineLevelActions>(RoutineLevelActions());
    GetIt.I.registerSingleton<RoutineStateActions>(RoutineStateActions());
    GetIt.I.registerSingleton<RoutineProcessorActions>(RoutineProcessorActions());
  }

  @override
  void validate() {
    RoutineRepository.instance.validate();
  }

  @override
  void postAssemble() {
    RoutineProcessorActions.instance.addProcessorCapacity(2);
  }

  @override
  void update(double deltaTime) {
    RoutineRepository.instance.update(deltaTime);
  }
}
