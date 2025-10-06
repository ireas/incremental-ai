import 'package:flutter/foundation.dart';
import 'package:incremental_ai/game/routine/enum/routine_state.dart';
import 'package:incremental_ai/game/routine/enum/routine_type.dart';

abstract class RoutineModel extends ChangeNotifier {
  late final String id;
  final RoutineType type;
  RoutineState state = RoutineState.locked;
  int level = 0;

  RoutineModel({required this.type}) {
    id = "routine.${type.name}";
  }

  void update(double deltaTime);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RoutineModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          type == other.type &&
          state == other.state &&
          level == other.level;

  @override
  int get hashCode => Object.hash(id, type, state, level);
}
