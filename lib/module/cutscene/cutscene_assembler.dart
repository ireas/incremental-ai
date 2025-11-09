import 'package:get_it/get_it.dart';
import 'package:incremental_ai/engine/archetype/assembler/assembler_archetype.dart';
import 'package:incremental_ai/engine/archetype/assembler/supports_action.dart';
import 'package:incremental_ai/engine/archetype/assembler/supports_repository.dart';
import 'package:incremental_ai/engine/utility/has_update.dart';
import 'package:incremental_ai/module/cutscene/action/cutscene_create_action.dart';
import 'package:incremental_ai/module/cutscene/action/cutscene_manage_action.dart';
import 'package:incremental_ai/module/cutscene/cutscene_repository.dart';

/// Assembler for the Cutscene module.
class CutsceneAssembler extends AssemblerArchetype with SupportsRepository, SupportsAction, HasUpdate {
  @override
  Future<void> assembleActions() async {
    GetIt.I.registerSingleton<CutsceneCreateAction>(CutsceneCreateAction());
    GetIt.I.registerSingleton<CutsceneManageAction>(CutsceneManageAction());
  }

  @override
  Future<void> assembleRepositories() async {
    CutsceneRepository repository = CutsceneRepository();
    await repository.initializeModels();
    GetIt.I.registerSingleton<CutsceneRepository>(repository);
  }

  @override
  void update(double deltaTime) {
    CutsceneRepository.instance.update(deltaTime);
  }
}
