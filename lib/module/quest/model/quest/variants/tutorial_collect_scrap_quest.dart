import 'package:get_it/get_it.dart';
import 'package:incremental_ai/module/cutscene/action/cutscene_create_action.dart';
import 'package:incremental_ai/module/cutscene/model/cutscene/cutscene_model.dart';
import 'package:incremental_ai/module/notification/action/notification_actions.dart';
import 'package:incremental_ai/module/notification/model/notification/notification_model.dart';
import 'package:incremental_ai/module/quest/model/objective/variants/collect_supply_objective.dart';
import 'package:incremental_ai/module/quest/model/objective/variants/reach_routine_level_objective.dart';
import 'package:incremental_ai/module/quest/model/quest/base/quest_model.dart';
import 'package:incremental_ai/module/quest/model/quest/quest_type.dart';
import 'package:incremental_ai/module/quest/quest_repository.dart';
import 'package:incremental_ai/module/routine/action/routine_state_actions.dart';
import 'package:incremental_ai/module/routine/model/routine/base/routine_model.dart';
import 'package:incremental_ai/module/routine/model/routine/routine_type.dart';
import 'package:incremental_ai/module/supply/action/supply_state_actions.dart';
import 'package:incremental_ai/module/supply/model/supply/base/supply_model.dart';
import 'package:incremental_ai/module/supply/model/supply/supply_type.dart';
import 'package:incremental_ai/module/upgrade/action/upgrade_state_actions.dart';
import 'package:incremental_ai/module/upgrade/model/upgrade/upgrade_type.dart';
import 'package:logger/logger.dart';

/// Tutorial quest that tasks the player to increase initial routine and collect some supply.
class TutorialCollectScrapQuest extends QuestModel {
  /// Constructor.
  TutorialCollectScrapQuest()
    : super(
        type: QuestType.tutorialOne,
        objectives: {
          ReachRoutineLevelObjective(RoutineType.scrapDrones, 1),
          CollectSupplyObjective(SupplyType.scrap, 0.4),
        },
      );

  /// Unlocks initial [SupplyModel] and [RoutineModel].
  @override
  void onActivation() {
    SupplyStateActions.instance.unlock(SupplyType.scrap);
    SupplyStateActions.instance.unlock(SupplyType.mana);
    RoutineStateActions.instance.unlock(RoutineType.scrapDrones);
    UpgradeStateActions.instance.unlock(UpgradeType.increaseScrapCapacity);
  }

  /// Trigger next quest.
  @override
  void onCompletion() {
    // log
    Logger().i("COMPLETED!!!");

    // activate next quest
    GetIt.I<QuestRepository>().fetch(QuestType.tutorialTwo).activate();

    // unlock uporade
    UpgradeStateActions.instance.unlock(UpgradeType.increaseMultiScrapCapacity);

    // display notification
    NotificationActions.instance.addNotificationToQueue(
      NotificationModel(title: "Hermann", message: "Heyyyy du, was geht !?"),
    );
    NotificationActions.instance.addNotificationToQueue(NotificationModel(title: "Hermann", message: "Hallo?"));

    // display cutscene
    CutsceneModel cutscene = CutsceneModel(messages: ["AA", "BBB"], background: "before.png");
    CutsceneCreateAction.instance.create(cutscene);

    CutsceneModel cutscene2 = CutsceneModel(messages: ["CCC", "DDD"], background: "after.png");
    CutsceneCreateAction.instance.create(cutscene2);
  }

  /// Never fails.
  @override
  void onFail() {}
}
