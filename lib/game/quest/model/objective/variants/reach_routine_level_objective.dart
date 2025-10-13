import 'package:get_it/get_it.dart';
import 'package:incremental_ai/engine/localization/usecase/localization_placeholder_usecase.dart';
import 'package:incremental_ai/engine/localization/usecase/localization_translate_usecase.dart';
import 'package:incremental_ai/game/quest/model/objective/objective_model.dart';
import 'package:incremental_ai/game/routine/enum/routine_type.dart';
import 'package:incremental_ai/game/routine/usecase/routine_inspect_usecase.dart';

/// Objective that requires the player to reach a certain level for a specified routine.
class ReachRoutineLevelObjective extends ObjectiveModel {
  // source
  static const String _sourceId = "objective.reach_routine_level";

  // targets
  final RoutineType _targetRoutine;
  final int _targetLevel;
  int _currentLevel = 0;

  // user interface
  late final String _rawLabel;

  /// Constructor, sets [_rawLabel] and replaces final values.
  ReachRoutineLevelObjective(this._targetRoutine, this._targetLevel) {
    Map<String, String> replacements = {"routine": _targetRoutine.name, "target_level": _targetLevel.toString()};
    _rawLabel = GetIt.I<LocalizationTranslateUsecase>().translateAndReplace("$_sourceId.label", replacements);
  }

  /// Completes if [_targetRoutine] has value of at least [_targetLevel].
  @override
  bool isCompleted() {
    _currentLevel = GetIt.I<RoutineInspectUsecase>().level(_targetRoutine);
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
