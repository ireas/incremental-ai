import 'package:get_it/get_it.dart';
import 'package:incremental_ai/engine/module/module_usecase.dart';
import 'package:incremental_ai/game/routine/routine_repository.dart';

/// Actions regarding routine processor model.
class RoutineProcessorActions extends ModuleUsecase {
  /// Singleton instances served by [GetIt].
  static RoutineProcessorActions get instance => GetIt.I<RoutineProcessorActions>();

  /// Model repository.
  final RoutineRepository _repository;

  /// Constructor.
  RoutineProcessorActions(this._repository);

  /// Checks if processor model has at least the given [value].
  bool sufficient(int value) {
    return _repository.processorModel.value >= value;
  }

  /// Adds a positive or negative [value] to processor value.
  void addProcessorValue(int value) {
    logger.t("Increasing processor value by $value.");
    _repository.processorModel.value += value;
  }

  /// Adds a positive or negative [capacity] to processor capacity.
  void addProcessorCapacity(int capacity) {
    logger.t("Increasing processor capacity by $capacity.");
    _repository.processorModel.capacity += capacity;
    addProcessorValue(capacity);
  }
}
