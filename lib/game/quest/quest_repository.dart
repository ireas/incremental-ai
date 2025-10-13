import 'package:incremental_ai/engine/module/module_repository.dart';
import 'package:incremental_ai/game/quest/model/quest/quest_model.dart';
import 'package:incremental_ai/game/quest/model/quest/variants/tutorial_after_collect_scrap_quest.dart';
import 'package:incremental_ai/game/quest/model/quest/variants/tutorial_collect_scrap_quest.dart';

/// Repository for the quest module.
class QuestRepository extends ModuleRepository {
  // models
  final Map<String, QuestModel> models = {};

  @override
  Future<void> initializeModels() async {
    models[TutorialCollectScrapQuest.sourceId] = TutorialCollectScrapQuest();
    models[TutorialCollectScrapAfterQuest.sourceId] = TutorialCollectScrapAfterQuest();
  }

  @override
  void update(double deltaTime) {
    for (QuestModel model in models.values) {
      model.update(deltaTime);
    }
  }

  /// Fetches a [QuestModel] that is identified by its [id].
  /// If no entry is found, returns [NULL].
  QuestModel? fetch(String id) {
    QuestModel? model = models[id];
    if (model == null) {
      logger.w("No model found for $id");
    }
    return model;
  }
}
