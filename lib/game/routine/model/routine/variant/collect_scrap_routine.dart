import 'package:get_it/get_it.dart';
import 'package:incremental_ai/game/routine/model/enum/routine_state.dart';
import 'package:incremental_ai/game/routine/model/routine/routine_model.dart';
import 'package:incremental_ai/game/supply/enum/supply_type.dart';
import 'package:incremental_ai/game/supply/usecase/supply_modify_usecase.dart';

/// Initial routine that collects scrap supply in regular intervals.
class CollectScrapRoutine extends RoutineModel {
  /// Source model id;
  static const String sourceId = "routine.collect_scrap";

  /// Source processing costs.
  static const int sourceProcessingCost = 1;

  /// Time in seconds that it takes to complete one routine interval.
  static const double _thresholdTime = 4;

  /// Current measured time since last interval has completed.
  double _currentTime = 0;

  /// Derived value that displays progress in interval, has range 0-1
  double progress = 0;

  /// Constructor.
  CollectScrapRoutine({super.id = sourceId, super.processingCost = sourceProcessingCost});

  @override
  void update(double deltaTime) {
    if (state == RoutineState.unlocked && level > 0) {
      _currentTime += deltaTime;
      if (_currentTime >= _thresholdTime) {
        _currentTime -= _thresholdTime;
        GetIt.I<SupplyModifyUsecase>().increaseValue(SupplyType.scrap, 0.1 * level);
      }
      progress = (_currentTime / _thresholdTime).clamp(0, 1);
    }

    notifyListeners();
  }
}
