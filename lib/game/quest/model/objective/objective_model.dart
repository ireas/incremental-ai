import 'package:flutter/foundation.dart';
import 'package:incremental_ai/game/quest/model/objective/objective_state.dart';

/// Model that describes a single objective to complete.
abstract class ObjectiveModel extends ChangeNotifier {
  // state
  ObjectiveState _state = ObjectiveState.active;

  ObjectiveState get state => _state;

  // user interface
  String _labelDescription = "";

  String get label => _labelDescription;

  /// Constructor.
  ObjectiveModel();

  /// Updates the objective state and label and notifies listeners.
  /// First checks for completion. If objective is not completed, checks failing condition.
  /// If objective is not active (i.e. [_state] is completed or failed), update is skipped.
  void update() {
    // skip update for non-active objectives
    if (_state != ObjectiveState.active) {
      return;
    }

    // check for completion of fail conditions
    if (isCompleted()) {
      _state = ObjectiveState.completed;
    } else if (isFailed()) {
      _state = ObjectiveState.failed;
    }

    // update label
    _labelDescription = buildLabel();

    // notify listeners
    notifyListeners();
  }

  /// Determines and returns whether the objective is completed.
  /// Details depend on variant.
  bool isCompleted();

  /// Determines and returns whether the objective is failed.
  /// Details depend on variant.
  bool isFailed();

  /// Builds the label which gets displayed in the UI.
  /// Details depend on variant.
  String buildLabel();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ObjectiveModel &&
          runtimeType == other.runtimeType &&
          _state == other._state &&
          _labelDescription == other._labelDescription;

  @override
  int get hashCode => Object.hash(_state, _labelDescription);
}
