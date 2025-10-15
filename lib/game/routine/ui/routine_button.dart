import 'package:flutter/material.dart';
import 'package:incremental_ai/engine/localization/usecase/localization_translate_usecase.dart';
import 'package:incremental_ai/engine/ui/widget/multi_click_button.dart';
import 'package:incremental_ai/game/routine/action/routine_level_actions.dart';
import 'package:incremental_ai/game/routine/model/enum/routine_state.dart';
import 'package:incremental_ai/game/routine/model/routine/routine_model.dart';
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
  final RoutineModel model;

  /// Constructor.
  const RoutineButton({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    // watch source model
    RoutineModel current = watch<RoutineModel>(model);

    // do not show any widget if routine is not active
    if (current.state != RoutineState.unlocked) {
      return SizedBox(height: 0, width: 0);
    }

    // fetch all strings
    // TODO: make static strings load once in constructor instead of each rebuild since they do not change anyway.
    String name = GetIt.I<LocalizationTranslateUsecase>().translate("routine.${current.id}.name");
    String processorName = GetIt.I<LocalizationTranslateUsecase>().translate("routine.processor.name");
    String cost = "(${current.processingCost} $processorName)";
    String tooltip = GetIt.I<LocalizationTranslateUsecase>().translate("routine.${current.id}.tooltip");

    // create button that listens to left and right clicks and can show a tooltip
    return MultiClickButton(
      onLeftClick: () => GetIt.I<RoutineLevelActions>().increment(current.id),
      onRightClick: () => GetIt.I<RoutineLevelActions>().decrement(current.id),
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
                Text("${current.level}"),
                Text(cost),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
