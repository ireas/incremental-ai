import 'package:incremental_ai/game/routine/model/routine/base/routine_model.dart';
import 'package:incremental_ai/game/routine/model/routine/routine_state.dart';
import 'package:incremental_ai/game/routine/model/routine/routine_type.dart';
import 'package:incremental_ai/game/supply/action/supply_amount_actions.dart';
import 'package:incremental_ai/game/supply/component/supply_amount_tuple.dart';
import 'package:incremental_ai/game/supply/model/supply/supply_type.dart';

/// Initial routine that collects scrap supply in regular intervals.
class CollectScrapRoutine extends RoutineModel {
  /// Time in seconds that it takes to complete one routine interval.
  static const double _thresholdTime = 4;

  /// Current measured time since last interval has completed.
  double _currentTime = 0;

  /// Derived value that displays progress in interval, has range 0-1
  double progress = 0;

  /// Constructor.
  CollectScrapRoutine({super.type = RoutineType.scrapDrones, super.processingCost = 1});

  @override
  void update(double deltaTime) {
    if (state == RoutineState.unlocked && level > 0) {
      _currentTime += deltaTime;
      if (_currentTime >= _thresholdTime) {
        _currentTime -= _thresholdTime;
        SupplyAmountActions.instance.add(SupplyAmountTuple(type: SupplyType.scrap, amount: 0.1 * level));
        SupplyAmountActions.instance.add(SupplyAmountTuple(type: SupplyType.mana, amount: 0.05 * level));
      }
      progress = (_currentTime / _thresholdTime).clamp(0, 1);
    }

    notifyListeners();
  }
}
