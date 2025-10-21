import 'package:incremental_ai/game/quest/model/objective/variants/collect_supply_objective.dart';
import 'package:incremental_ai/game/quest/model/quest/base/quest_model.dart';
import 'package:incremental_ai/game/quest/model/quest/quest_type.dart';
import 'package:incremental_ai/game/supply/model/supply/supply_type.dart';
import 'package:logger/logger.dart';

/// Tutorial quest that is called after first one.
class TutorialCollectScrapAfterQuest extends QuestModel {
  /// Constructor.
  TutorialCollectScrapAfterQuest()
    : super(type: QuestType.tutorialTwo, objectives: {CollectSupplyObjective(SupplyType.scrap, 20)});

  /// No requirements needed on activation.
  @override
  void onActivation() {}

  /// Informs developer on completion.
  @override
  void onCompletion() {
    Logger().i("COMPLETED AGAIN WOW!!!");
  }

  /// Never fails.
  @override
  void onFail() {}
}
