import 'package:get_it/get_it.dart';
import 'package:incremental_ai/engine/module/module_usecase.dart';
import 'package:incremental_ai/game/supply/component/supply_amount_tuple.dart';
import 'package:incremental_ai/game/supply/model/supply/base/supply_model.dart';
import 'package:incremental_ai/game/supply/supply_repository.dart';

/// Actions regarding supply capacities.
class SupplyCapacityActions extends ModuleActions {
  /// Singleton instance served by [GetIt].
  static SupplyCapacityActions get instance => GetIt.I<SupplyCapacityActions>();

  /// Adds capacity to supply.
  /// Target supply to check and value to add are part of input [tuple].
  void increase(SupplyAmountTuple tuple) {
    SupplyModel supply = SupplyRepository.instance.fetch(tuple.type);
    supply.capacity += tuple.amount;
  }
}
