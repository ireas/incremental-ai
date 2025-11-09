import 'package:get_it/get_it.dart';
import 'package:incremental_ai/engine/archetype/action/action_archetype.dart';
import 'package:incremental_ai/module/supply/component/supply_amount_tuple.dart';
import 'package:incremental_ai/module/supply/model/supply/base/supply_model.dart';
import 'package:incremental_ai/module/supply/supply_repository.dart';

/// Actions regarding supply capacities.
class SupplyCapacityActions extends ActionArchetype {
  /// Singleton instance.
  static SupplyCapacityActions get instance => GetIt.I<SupplyCapacityActions>();

  /// Adds capacity to supply.
  /// Target supply to check and value to add are part of input [tuple].
  void increase(SupplyAmountTuple tuple) {
    SupplyModel supply = SupplyRepository.instance.fetch(tuple.type);
    supply.capacity += tuple.amount;
  }
}
