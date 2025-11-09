import 'package:get_it/get_it.dart';
import 'package:incremental_ai/engine/archetype/repository/repository_archetype.dart';
import 'package:incremental_ai/engine/utility/has_update.dart';
import 'package:incremental_ai/engine/utility/has_validation.dart';
import 'package:incremental_ai/module/quest/model/quest/base/quest_model.dart';
import 'package:incremental_ai/module/quest/model/quest/quest_type.dart';
import 'package:incremental_ai/module/quest/model/quest/variants/tutorial_after_collect_scrap_quest.dart';
import 'package:incremental_ai/module/quest/model/quest/variants/tutorial_collect_scrap_quest.dart';

/// Repository for the quest module.
class QuestRepository extends RepositoryArchetype with HasValidation, HasUpdate {
  /// Singleton instance.
  static QuestRepository get instance => GetIt.I<QuestRepository>();

  /// All models mapped by their type.
  final Map<QuestType, QuestModel> _models = {};

  @override
  Future<void> initializeModels() async {
    _models[QuestType.tutorialOne] = TutorialCollectScrapQuest();
    _models[QuestType.tutorialTwo] = TutorialCollectScrapAfterQuest();
  }

  @override
  void validate() {
    for (QuestType type in QuestType.values) {
      if (!_models.containsKey(type)) {
        logger.e("No model defined for $type");
      }
    }
  }

  @override
  void update(double deltaTime) {
    for (QuestModel model in _models.values) {
      model.update(deltaTime);
    }
    notifyListeners();
  }

  /// Fetches the model corresponding to [type] from [_models].
  /// If no model is defined for type, throws [StateError].
  QuestModel fetch(QuestType type) {
    return _models[type] ?? (throw StateError('No model found for $type'));
  }

  /// Fetches all models in [_models] map and returns them as list.
  List<QuestModel> fetchAll() {
    return _models.values.toList();
  }
}
