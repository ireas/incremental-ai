import 'package:get_it/get_it.dart';
import 'package:incremental_ai/engine/archetype/action/action_archetype.dart';
import 'package:incremental_ai/module/routine/routine_repository.dart';

/// Actions regarding routine processor model.
class RoutineProcessorActions extends ActionArchetype {
  /// Singleton instance.
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
