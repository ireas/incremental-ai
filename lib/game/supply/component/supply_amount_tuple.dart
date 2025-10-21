import 'package:incremental_ai/game/supply/model/supply/supply_type.dart';

/// Tuple that contains a [type] and a [amount].
/// Can be used to describe supply costs or rewards.
class SupplyAmountTuple {
  final SupplyType type;
  final double amount;

  /// Constructor.
  SupplyAmountTuple({required this.type, required this.amount});
}
