import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:incremental_ai/engine/localization/usecase/localization_translate_usecase.dart';
import 'package:incremental_ai/game/quest/model/objective/objective_model.dart';
import 'package:incremental_ai/game/quest/model/objective/objective_state.dart';
import 'package:incremental_ai/game/quest/model/quest/quest_state.dart';

/// Models a single quest the player is tasked. Consists of one or more [ObjectiveModel].
abstract class QuestModel extends ChangeNotifier {
  // source
  final String id;
  final Set<ObjectiveModel> objectives;

  // state
  QuestState _state = QuestState.inactive;

  QuestState get state => _state;

  // user interface
  late final String labelName;

  /// Constructor.
  /// Automatically builds [labelName] from [id].
  QuestModel(this.id, this.objectives) {
    labelName = GetIt.I<LocalizationTranslateUsecase>().translate("$id.name");
  }

  /// Updates the quest [objectives], [state] and notifies listeners.
  /// Here, [deltaTime] is the time since last update in seconds.
  /// If quest [state] is not active, update will be skipped.
  void update(double deltaTime) {
    // skip non-active quests
    if (_state != QuestState.active) {
      return;
    }

    // update all objectives
    for (ObjectiveModel objective in objectives) {
      objective.update();
    }

    // check completion
    bool allCompleted = true;
    for (ObjectiveModel objective in objectives) {
      if (objective.state != ObjectiveState.completed) {
        allCompleted = false;
        break;
      }
    }

    // complete quest if all objectives are completed
    if (allCompleted) {
      _state = QuestState.completed;
      onCompletion();
      notifyListeners();
      return;
    }

    // otherwise fail quest if any objective has failed
    for (ObjectiveModel objective in objectives) {
      if (objective.state == ObjectiveState.failed) {
        _state = QuestState.failed;
        onFail();
        notifyListeners();
        return;
      }
    }

    // notify listeners on any return
    notifyListeners();
  }

  /// Activates a quest. Works only for quests that are not yet completed or failed.
  void activate() {
    if (state != QuestState.inactive) {
      return;
    }
    _state = QuestState.active;
    onActivation();
  }
  /// Is called on activation and can trigger any requirements.
  void onActivation();

  /// Is called on completion and can trigger any result.
  void onCompletion();

  /// Is called on fail and can trigger any result.
  void onFail();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuestModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          objectives == other.objectives &&
          _state == other._state &&
          labelName == other.labelName;

  @override
  int get hashCode => Object.hash(id, objectives, _state, labelName);
}
