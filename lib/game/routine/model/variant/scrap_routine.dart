import 'package:get_it/get_it.dart';
import 'package:incremental_ai/game/routine/enum/routine_state.dart';
import 'package:incremental_ai/game/routine/enum/routine_type.dart';
import 'package:incremental_ai/game/routine/model/routine_model.dart';
import 'package:incremental_ai/game/supply/enum/supply_type.dart';
import 'package:incremental_ai/game/supply/usecase/supply_modify_usecase.dart';

class CollectScrapRoutine extends RoutineModel {
  static const RoutineType sourceType = RoutineType.collectScrap;
  static const double _thresholdTime = 4;
  double _currentTime = 0;
  double progress = 0;

  CollectScrapRoutine({super.type = sourceType});

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
