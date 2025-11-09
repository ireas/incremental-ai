import 'package:flutter/foundation.dart';
import 'package:incremental_ai/module/routine/model/routine/routine_state.dart';
import 'package:incremental_ai/module/routine/model/routine/routine_type.dart';

/// Model that describes a activatable routine.
abstract class RoutineModel extends ChangeNotifier {
  /// Unique mode id.
  late final String id;

  final RoutineType type;

  /// Number of processor units needed for level increase.
  final int processingCost;

  /// Current model state
  RoutineState state = RoutineState.locked;

  /// Current activation level of routine, higher levels increase efficiency.
  int level = 0;

  /// Constructor. Automatically constructs id from [type].
  RoutineModel({required this.type, required this.processingCost}) {
    id = "routine.${type.name}";
  }

  /// Update method that progresses the routine result.
  /// The [deltaTime] parameter is the time in seconds since the last update call.
  ///
  /// Should call [notifyListeners] on value change.
  void update(double deltaTime);
}
