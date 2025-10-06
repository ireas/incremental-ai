import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:incremental_ai/game/supply/enum/supply_state.dart';
import 'package:incremental_ai/game/supply/enum/supply_type.dart';

class SupplyModel extends ChangeNotifier {
  late final String id;
  final SupplyType type;
  final Color color;
  SupplyState state = SupplyState.locked;
  double value = 0;
  double capacity = 1;
  double rate = 0;

  SupplyModel({required this.type, required this.color}) {
    id = "supply.${type.name}";
  }

  void update(double deltaTime) {
    if (state == SupplyState.unlocked) {
      value += (deltaTime * rate).clamp(0, capacity);
    }
    notifyListeners();
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SupplyModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          type == other.type &&
          color == other.color &&
          state == other.state &&
          value == other.value &&
          capacity == other.capacity &&
          rate == other.rate;

  @override
  int get hashCode => Object.hash(id, type, color, state, value, capacity, rate);
}
