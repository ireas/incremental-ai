import 'package:incremental_ai/engine/cycle/preload/cycle_preloader_plugin.dart';
import 'package:incremental_ai/game/routine/action/routine_processor_actions.dart';

/// Preloader that initializes the routine processors with initial capacity.
class RoutinePreloader extends CyclePreloaderPlugin {
  @override
  void preload() {
    RoutineProcessorActions.instance.addProcessorCapacity(2);
  }
}
