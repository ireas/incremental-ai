import 'package:incremental_ai/game/quest/model/objective/objective_model.dart';
import 'package:incremental_ai/game/quest/model/objective/variants/collect_supply_objective.dart';
import 'package:incremental_ai/game/quest/model/quest/quest_model.dart';
import 'package:incremental_ai/game/supply/enum/supply_type.dart';
import 'package:logger/logger.dart';

/// Tutorial quest that is called after first one.
class TutorialCollectScrapAfterQuest extends QuestModel {
  // source
  static const String sourceId = "quest.tutorial.collect_scrap_after";
  static final Set<ObjectiveModel> sourceObjectives = {CollectSupplyObjective(SupplyType.scrap, 20)};

  /// Constructor.
  TutorialCollectScrapAfterQuest() : super(sourceId, sourceObjectives);

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
