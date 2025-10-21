import 'package:get_it/get_it.dart';
import 'package:incremental_ai/engine/module/module_usecase.dart';
import 'package:incremental_ai/game/routine/routine_repository.dart';

/// Actions regarding routine processor model.
class RoutineProcessorActions extends ModuleActions {
  /// Singleton instances served by [GetIt].
  static RoutineProcessorActions get instance => GetIt.I<RoutineProcessorActions>();

  /// Checks if processor model has at least the given [value].
  bool sufficient(int value) {
    return RoutineRepository.instance.processorModel.value >= value;
  }

  /// Adds a positive or negative [value] to processor value.
  void addProcessorValue(int value) {
    logger.t("Increasing processor value by $value.");
    RoutineRepository.instance.processorModel.value += value;
  }

  /// Adds a positive or negative [capacity] to processor capacity.
  void addProcessorCapacity(int capacity) {
    logger.t("Increasing processor capacity by $capacity.");
    RoutineRepository.instance.processorModel.capacity += capacity;
    addProcessorValue(capacity);
  }
}
