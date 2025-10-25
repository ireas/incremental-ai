import 'package:flutter/material.dart';
import 'package:incremental_ai/engine/localization/usecase/localization_translate_usecase.dart';
import 'package:incremental_ai/engine/ui/button/multi_click_button.dart';
import 'package:incremental_ai/game/routine/action/routine_level_actions.dart';
import 'package:incremental_ai/game/routine/model/routine/base/routine_model.dart';
import 'package:incremental_ai/game/routine/model/routine/routine_type.dart';
import 'package:incremental_ai/game/routine/routine_repository.dart';
import 'package:watch_it/watch_it.dart';

/// UI widget for displaying a single routine in UI.
/// The widget is a button that allows increasing and decreasing activation levels via left and right clicks.
/// It displays the following information
/// - name
/// - description (on hover)
/// - current activation level
/// - processing cost per activation
class RoutineButton extends WatchingWidget {
  /// Source routine model.
  final RoutineType type;

  /// Constructor.
  const RoutineButton({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    // watch model
    RoutineModel routine = watch<RoutineModel>(RoutineRepository.instance.fetch(type));

    // fetch all strings
    // TODO: make static strings load once in constructor instead of each rebuild since they do not change anyway.
    String name = GetIt.I<LocalizationTranslateUsecase>().translate("routine.${routine.id}.name");
    String processorName = GetIt.I<LocalizationTranslateUsecase>().translate("routine.processor.name");
    String cost = "(${routine.processingCost} $processorName)";
    String tooltip = GetIt.I<LocalizationTranslateUsecase>().translate("routine.${routine.id}.tooltip");

    // create button that listens to left and right clicks and can show a tooltip
    return MultiClickButton(
      onLeftClick: () => GetIt.I<RoutineLevelActions>().increment(type),
      onRightClick: () => GetIt.I<RoutineLevelActions>().decrement(type),
      child: SizedBox(
        height: 100,
        width: 100,
        child: Tooltip(
          message: tooltip,
          child: Container(
            color: Colors.lightBlueAccent,
            padding: EdgeInsets.all(5),
            child: Column(
              children: [
                Expanded(child: Text(name)),
                Text("${routine.level}"),
                Text(cost),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
