import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:incremental_ai/game/supply/model/supply/supply_state.dart';
import 'package:incremental_ai/game/supply/model/supply/supply_type.dart';

/// Base model for all supplies.
class SupplyModel extends ChangeNotifier {
  late final String id;
  final SupplyType type;
  final Color color;
  SupplyState state = SupplyState.locked;
  double amount = 0;
  double capacity = 1;
  double rate = 0;

  SupplyModel({required this.type, required this.color}) {
    id = "supply.${type.name}";
  }

  /// Updates the supply amount.
  /// The current rate is added to the amount.
  void update(double deltaTime) {
    if (state == SupplyState.unlocked) {
      amount += (deltaTime * rate).clamp(0, capacity);
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
          amount == other.amount &&
          capacity == other.capacity &&
          rate == other.rate;

  @override
  int get hashCode => Object.hash(id, type, color, state, amount, capacity, rate);
}
