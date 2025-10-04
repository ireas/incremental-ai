import 'package:get_it/get_it.dart';
import 'package:incremental_ai/game/routine/model/routine_model.dart';
import 'package:incremental_ai/game/supply/supply_manager.dart';

class ScrapRoutine extends RoutineModel {
  static const double _thresholdTime = 4;
  double _currentTime = 0;
  double progress = 0;

  ScrapRoutine({required super.id});

  @override
  void update(double deltaTime) {
    if (enabled && level > 0) {
      _currentTime += deltaTime;
      if (_currentTime >= _thresholdTime) {
        _currentTime -= _thresholdTime;
        GetIt.I<SupplyManager>().increaseValue("supply.scrap", 0.1 * level);
      }
      progress = (_currentTime / _thresholdTime).clamp(0, 1);
    }
    notifyListeners();
  }
}
