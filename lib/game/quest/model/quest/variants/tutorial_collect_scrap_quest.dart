import 'package:get_it/get_it.dart';
import 'package:incremental_ai/game/quest/model/objective/objective_model.dart';
import 'package:incremental_ai/game/quest/model/objective/variants/collect_supply_objective.dart';
import 'package:incremental_ai/game/quest/model/objective/variants/reach_routine_level_objective.dart';
import 'package:incremental_ai/game/quest/model/quest/quest_model.dart';
import 'package:incremental_ai/game/quest/model/quest/variants/tutorial_after_collect_scrap_quest.dart';
import 'package:incremental_ai/game/quest/quest_repository.dart';
import 'package:incremental_ai/game/routine/action/routine_state_actions.dart';
import 'package:incremental_ai/game/routine/model/routine/routine_model.dart';
import 'package:incremental_ai/game/routine/model/routine/variant/collect_scrap_routine.dart';
import 'package:incremental_ai/game/supply/enum/supply_type.dart';
import 'package:incremental_ai/game/supply/model/supply_model.dart';
import 'package:incremental_ai/game/supply/usecase/supply_modify_usecase.dart';
import 'package:logger/logger.dart';

/// Tutorial quest that tasks the player to increase initial routine and collect some supply.
class TutorialCollectScrapQuest extends QuestModel {
  // source
  static const String sourceId = "quest.tutorial.collect_scrap";
  static final Set<ObjectiveModel> sourceObjectives = {
    ReachRoutineLevelObjective(CollectScrapRoutine.sourceId, 1),
    CollectSupplyObjective(SupplyType.scrap, 1.0),
  };

  /// Constructor.
  TutorialCollectScrapQuest() : super(sourceId, sourceObjectives);

  /// Unlocks initial [SupplyModel] and [RoutineModel].
  @override
  void onActivation() {
    GetIt.I<SupplyModifyUsecase>().enable(SupplyType.scrap);
    RoutineStateActions.instance.enable(CollectScrapRoutine.sourceId);
  }

  /// Trigger next quest.
  @override
  void onCompletion() {
    Logger().i("COMPLETED!!!");
    GetIt.I<QuestRepository>().fetch(TutorialCollectScrapAfterQuest.sourceId)!.activate();
  }

  /// Never fails.
  @override
  void onFail() {}
}
