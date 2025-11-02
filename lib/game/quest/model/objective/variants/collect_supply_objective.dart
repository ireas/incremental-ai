import 'package:incremental_ai/engine/localization/action/localization_placeholder_action.dart';
import 'package:incremental_ai/engine/localization/action/localization_translate_action.dart';
import 'package:incremental_ai/game/quest/model/objective/objective_model.dart';
import 'package:incremental_ai/game/supply/action/supply_amount_actions.dart';
import 'package:incremental_ai/game/supply/model/supply/supply_type.dart';

/// Objective that requires the player to collect a required amount of a specified supply.
class CollectSupplyObjective extends ObjectiveModel {
  // source
  static const String _sourceId = "objective.collect_supply";

  // targets
  final SupplyType _targetSupply;
  final double _targetValue;
  double _currentValue = 0.0;

  // user interface
  late final String _rawLabel;

  /// Constructor, sets [_rawLabel] and replaces final values.
  CollectSupplyObjective(this._targetSupply, this._targetValue) {
    Map<String, String> replacements = {"supply": _targetSupply.name, "target_value": _targetValue.toString()};
    _rawLabel = LocalizationTranslateAction.instance.translateAndReplace("$_sourceId.label", replacements);
  }

  /// Completes if [_targetSupply] has value of at least [_targetValue].
  @override
  bool isCompleted() {
    _currentValue = SupplyAmountActions.instance.inspect(_targetSupply);
    return _currentValue >= _targetValue;
  }

  /// Never fails.
  @override
  bool isFailed() {
    return false;
  }

  /// Replaces dynamic values in [_rawLabel].
  @override
  String buildLabel() {
    Map<String, String> replacements = {"current_value": _currentValue.toString()};
    return LocalizationPlaceholderAction.instance.replacePlaceholders(_rawLabel, replacements);
  }
}
