import 'package:get_it/get_it.dart';
import 'package:incremental_ai/engine/cycle/preload/cycle_preloader.dart';
import 'package:incremental_ai/engine/module/assembly.dart';
import 'package:incremental_ai/engine/module/module_assembler.dart';
import 'package:incremental_ai/game/quest/cycle/quest_preloader.dart';
import 'package:incremental_ai/game/quest/quest_repository.dart';

/// Assembler for the Quest module.
class QuestAssembler extends ModuleAssembler {
  @override
  Future<void> assemble(Assembly assembler) async {
    // repository
    QuestRepository repository = QuestRepository();
    await repository.initializeModels();
    repository.validate();
    GetIt.I.registerSingleton<QuestRepository>(repository);
    assembler.registry.add(repository);

    // preload
    CyclePreloader.instance.register(QuestPreloader());
  }
}
