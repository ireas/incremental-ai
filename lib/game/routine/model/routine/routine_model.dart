import 'package:flutter/foundation.dart';
import 'package:incremental_ai/game/routine/model/enum/routine_state.dart';

/// Model that describes a activatable routine.
abstract class RoutineModel extends ChangeNotifier {
  /// Unique mode id.
  late final String id;

  /// Number of processor units needed for level increase.
  final int processingCost;

  /// Current model state
  RoutineState state = RoutineState.locked;

  /// Current activation level of routine, higher levels increase efficiency.
  int level = 0;

  /// Constructor. Automatically constructs id from [type].
  RoutineModel({required this.id, this.processingCost = 0});

  /// Update method that progresses the routine result.
  /// The [deltaTime] parameter is the time in seconds since the last update call.
  ///
  /// Should call [notifyListeners] on value change.
  void update(double deltaTime);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RoutineModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          state == other.state &&
          level == other.level;

  @override
  int get hashCode => Object.hash(id, state, level);
}
