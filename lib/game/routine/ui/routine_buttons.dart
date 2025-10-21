import 'package:flutter/material.dart';
import 'package:incremental_ai/game/routine/model/routine/routine_state.dart';
import 'package:incremental_ai/game/routine/routine_repository.dart';
import 'package:incremental_ai/game/routine/ui/routine_button.dart';
import 'package:watch_it/watch_it.dart';

/// UI widget that shows all routine models in simple column.
class RoutineButtons extends WatchingWidget {
  /// Set of all states that should be visible in the UI.
  static const Set<RoutineState> visibleStates = {RoutineState.unlocked};

  /// Constructor.
  const RoutineButtons({super.key});

  @override
  Widget build(BuildContext context) {
    // watch the repository
    RoutineRepository repository = watch<RoutineRepository>(RoutineRepository.instance);

    // vertical list of each visible routine
    return Column(
      children: repository
          .fetchAll()
          .where((e) => visibleStates.contains(e.state))
          .map((e) => RoutineButton(type: e.type))
          .toList(),
    );
  }
}
