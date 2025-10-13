import 'package:get_it/get_it.dart';
import 'package:incremental_ai/engine/module/assembly.dart';
import 'package:incremental_ai/engine/module/module_assembler.dart';
import 'package:incremental_ai/game/quest/quest_repository.dart';

/// Assembler for the quest module.
class QuestAssembler extends ModuleAssembler {
  @override
  Future<void> assemble(Assembly assembler) async {
    // repository
    QuestRepository repository = QuestRepository();
    await repository.initializeModels();
    GetIt.I.registerSingleton<QuestRepository>(repository);
    assembler.registry.add(repository);

    // usecases
  }
}
