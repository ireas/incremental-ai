import 'package:get_it/get_it.dart';
import 'package:incremental_ai/engine/archetype/assembler/assembler_archetype.dart';
import 'package:incremental_ai/engine/archetype/assembler/supports_post_assemble.dart';
import 'package:incremental_ai/engine/archetype/assembler/supports_repository.dart';
import 'package:incremental_ai/engine/utility/has_update.dart';
import 'package:incremental_ai/engine/utility/has_validation.dart';
import 'package:incremental_ai/module/quest/model/quest/quest_type.dart';
import 'package:incremental_ai/module/quest/quest_repository.dart';

/// Assembler for the Quest module.
class QuestAssembler extends AssemblerArchetype
    with SupportsRepository, HasValidation, SupportsPostAssemble, HasUpdate {
  @override
  Future<void> assembleRepositories() async {
    QuestRepository repository = QuestRepository();
    await repository.initializeModels();
    GetIt.I.registerSingleton<QuestRepository>(repository);
  }

  @override
  void validate() {
    QuestRepository.instance.validate();
  }

  @override
  void update(double deltaTime) {
    QuestRepository.instance.update(deltaTime);
  }

  @override
  void postAssemble() {
    QuestRepository.instance.fetch(QuestType.tutorialOne).activate();
  }
}
