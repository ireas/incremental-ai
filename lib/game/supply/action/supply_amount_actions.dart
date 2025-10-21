import 'package:get_it/get_it.dart';
import 'package:incremental_ai/engine/module/module_usecase.dart';
import 'package:incremental_ai/game/supply/component/supply_amount_tuple.dart';
import 'package:incremental_ai/game/supply/model/supply/supply_type.dart';
import 'package:incremental_ai/game/supply/supply_repository.dart';

/// Actions regarding supply amounts.
class SupplyAmountActions extends ModuleActions {
  /// Singleton instance served by [GetIt].
  static SupplyAmountActions get instance => GetIt.I<SupplyAmountActions>();

  /// Fetches current value, targets model with set [type].
  double inspect(SupplyType type) {
    return SupplyRepository.instance.fetch(type).amount;
  }

  /// Checks whether the the player has sufficient supply.
  /// Target supply to check and minimum amount are part of input [tuple].
  bool hasSufficient(SupplyAmountTuple tuple) {
    return SupplyRepository.instance.fetch(tuple.type).amount >= tuple.amount;
  }

  /// Adds amount of [tuple] to supply defined by type in [tuple].
  void add(SupplyAmountTuple tuple) {
    SupplyRepository.instance.fetch(tuple.type).amount += tuple.amount;
  }

  /// Subtracts amount of [tuple] to supply defined by type in [tuple].
  void subtract(SupplyAmountTuple tuple) {
    SupplyRepository.instance.fetch(tuple.type).amount -= tuple.amount;
  }
}
