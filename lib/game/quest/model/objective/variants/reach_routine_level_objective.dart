import 'package:get_it/get_it.dart';
import 'package:incremental_ai/engine/localization/usecase/localization_placeholder_usecase.dart';
import 'package:incremental_ai/engine/localization/usecase/localization_translate_usecase.dart';
import 'package:incremental_ai/game/quest/model/objective/objective_model.dart';
import 'package:incremental_ai/game/routine/action/routine_level_actions.dart';
import 'package:incremental_ai/game/routine/model/routine/base/routine_model.dart';
import 'package:incremental_ai/game/routine/model/routine/routine_type.dart';
import 'package:incremental_ai/game/routine/routine_repository.dart';

/// Objective that requires the player to reach a certain level for a specified routine.
class ReachRoutineLevelObjective extends ObjectiveModel {
  // source
  static const String _sourceId = "objective.reach_routine_level";

  // targets
  final RoutineType _targetRoutineType;
  final int _targetLevel;
  int _currentLevel = 0;

  // user interface
  late final String _rawLabel;

  /// Constructor, sets [_rawLabel] and replaces final values.
  ReachRoutineLevelObjective(this._targetRoutineType, this._targetLevel) {
    RoutineModel routine = GetIt.I<RoutineRepository>().fetch(_targetRoutineType);
    Map<String, String> replacements = {"routine": routine.id, "target_level": _targetLevel.toString()};
    _rawLabel = GetIt.I<LocalizationTranslateUsecase>().translateAndReplace("$_sourceId.label", replacements);
  }

  /// Completes if [_targetRoutineType] has value of at least [_targetLevel].
  @override
  bool isCompleted() {
    _currentLevel = RoutineLevelActions.instance.level(_targetRoutineType);
    return _currentLevel >= _targetLevel;
  }

  /// Never fails.
  @override
  bool isFailed() {
    return false;
  }

  /// Replaces dynamic values in [_rawLabel].
  @override
  String buildLabel() {
    Map<String, String> replacements = {"current_level": _currentLevel.toString()};
    return GetIt.I<LocalizationPlaceholderUsecase>().replacePlaceholders(_rawLabel, replacements);
  }
}
