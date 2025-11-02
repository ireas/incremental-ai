import 'package:get_it/get_it.dart';
import 'package:incremental_ai/game/notification/action/notification_actions.dart';
import 'package:incremental_ai/game/notification/model/notification/notification_model.dart';
import 'package:incremental_ai/game/quest/model/objective/variants/collect_supply_objective.dart';
import 'package:incremental_ai/game/quest/model/objective/variants/reach_routine_level_objective.dart';
import 'package:incremental_ai/game/quest/model/quest/base/quest_model.dart';
import 'package:incremental_ai/game/quest/model/quest/quest_type.dart';
import 'package:incremental_ai/game/quest/quest_repository.dart';
import 'package:incremental_ai/game/routine/action/routine_state_actions.dart';
import 'package:incremental_ai/game/routine/model/routine/base/routine_model.dart';
import 'package:incremental_ai/game/routine/model/routine/routine_type.dart';
import 'package:incremental_ai/game/supply/action/supply_state_actions.dart';
import 'package:incremental_ai/game/supply/model/supply/base/supply_model.dart';
import 'package:incremental_ai/game/supply/model/supply/supply_type.dart';
import 'package:incremental_ai/game/upgrade/action/upgrade_state_actions.dart';
import 'package:incremental_ai/game/upgrade/model/upgrade/upgrade_type.dart';
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
    RoutineStateActions.instance.unlock(RoutineType.scrapDrones);
    UpgradeStateActions.instance.unlock(UpgradeType.increaseScrapCapacity);
  }

  /// Trigger next quest.
  @override
  void onCompletion() {
    Logger().i("COMPLETED!!!");
    GetIt.I<QuestRepository>().fetch(QuestType.tutorialTwo).activate();
    UpgradeStateActions.instance.unlock(UpgradeType.increaseMultiScrapCapacity);
    NotificationActions.instance.addNotificationToQueue(NotificationModel(title: "Hermann", message: "Heyyyy du, was geht !?"));
    NotificationActions.instance.addNotificationToQueue(NotificationModel(title: "Hermann", message: "Hallo?"));
  }

  /// Never fails.
  @override
  void onFail() {}
}
