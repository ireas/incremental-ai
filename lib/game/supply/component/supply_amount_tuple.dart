import 'package:incremental_ai/game/supply/enum/supply_type.dart';

/// Tuple that contains a [supply] and a [amount].
/// Can be used to describe supply costs or rewards.
class SupplyAmountTuple {
  final SupplyType supply;
  final double amount;

  SupplyAmountTuple({required this.supply, required this.amount});
}
