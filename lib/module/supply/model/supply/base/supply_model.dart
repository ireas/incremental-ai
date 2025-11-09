import 'package:flutter/material.dart';
import 'package:incremental_ai/module/supply/model/supply/supply_state.dart';
import 'package:incremental_ai/module/supply/model/supply/supply_type.dart';

/// Base model for all supplies.
class SupplyModel extends ChangeNotifier {
  final SupplyType type;
  final Color color;
  SupplyState state = SupplyState.locked;

  /// Current amount available, in range from 0 to [capacity].
  double _amount = 0;

  double get amount => _amount;

  set amount(double value) {
    _amount = value.clamp(0, capacity);
  }

  /// Maximum [amount] that can be stored.
  double capacity = 1;

  /// Change in [amount] per second.
  double rate = 0;

  /// Constructor.
  SupplyModel({required this.type, required this.color});

  /// Updates the supply amount.
  /// The current rate is added to the amount.
  void update(double deltaTime) {
    if (state == SupplyState.unlocked) {
      amount += deltaTime * rate;
    }
    notifyListeners();
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SupplyModel &&
          runtimeType == other.runtimeType &&
          type == other.type &&
          color == other.color &&
          state == other.state &&
          amount == other.amount &&
          capacity == other.capacity &&
          rate == other.rate;

  @override
  int get hashCode => Object.hash(type, color, state, amount, capacity, rate);
}
