import 'package:incremental_ai/engine/cycle/preload/cycle_preloader_plugin.dart';
import 'package:incremental_ai/game/quest/model/quest/quest_type.dart';
import 'package:incremental_ai/game/quest/quest_repository.dart';

/// Preloader that activates the first tutorial class.
class QuestPreloader extends CyclePreloaderPlugin {
  @override
  void preload() {
    QuestRepository.instance.fetch(QuestType.tutorialOne).activate();
  }
}
