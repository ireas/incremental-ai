import 'package:get_it/get_it.dart';
import 'package:incremental_ai/engine/module/module_usecase.dart';
import 'package:incremental_ai/game/supply/component/supply_amount_tuple.dart';
import 'package:incremental_ai/game/supply/model/supply_model.dart';
import 'package:incremental_ai/game/supply/supply_repository.dart';

/// Actions regarding supply value.
class SupplyValueActions extends ModuleUsecase {
  /// Singleton instance served by [GetIt].
  static SupplyValueActions get instance => GetIt.I<SupplyValueActions>();

  /// Model repository.
  final SupplyRepository _repository;

  /// Constructor.
  SupplyValueActions(this._repository);

  /// Checks whether the the player has sufficient supply.
  /// Target supply to check and minimum amount are part of input [tuple].
  bool hasSufficient(SupplyAmountTuple tuple) {
    SupplyModel supply = _repository.fetch(tuple.supply);
    return supply.value >= tuple.amount;
  }

  void addAmount(SupplyAmountTuple tuple) {
    SupplyModel supply = _repository.fetch(tuple.supply);
    supply.value += tuple.amount;
  }

  void subtractAmount(SupplyAmountTuple tuple) {
    SupplyModel supply = _repository.fetch(tuple.supply);
    supply.value -= tuple.amount;
  }
}
