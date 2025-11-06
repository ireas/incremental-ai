import 'package:get_it/get_it.dart';
import 'package:incremental_ai/engine/cutscene/action/cutscene_create_action.dart';
import 'package:incremental_ai/engine/cutscene/action/cutscene_manage_action.dart';
import 'package:incremental_ai/engine/cutscene/cutscene_repository.dart';
import 'package:incremental_ai/engine/module/assembly.dart';
import 'package:incremental_ai/engine/module/module_assembler.dart';

/// Assembler for the Cutscene module.
class CutsceneAssembler extends ModuleAssembler {
  @override
  Future<void> assemble(Assembly assembler) async {
    // repository
    CutsceneRepository repository = CutsceneRepository();
    await repository.initializeModels();
    repository.validate();
    GetIt.I.registerSingleton<CutsceneRepository>(repository);
    assembler.registry.add(repository);

    // actions
    GetIt.I.registerSingleton<CutsceneCreateAction>(CutsceneCreateAction());
    GetIt.I.registerSingleton<CutsceneManageAction>(CutsceneManageAction());
  }
}
