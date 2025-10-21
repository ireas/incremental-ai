import 'package:incremental_ai/game/supply/component/supply_amount_tuple.dart';
import 'package:incremental_ai/game/upgrade/model/upgrade/base/upgrade_model.dart';

/// Model preset for single-purchase upgrades.
abstract class SingleUpgradeModel extends UpgradeModel {
  final List<SupplyAmountTuple> costs;

  /// Constructor, requires cost for upgrade and limits maximum number of purchases to 1.
  SingleUpgradeModel({required super.type, required this.costs, super.maximumNumberOfPurchases = 1});

  /// Only one purchase is allowed, so we can return a simple supply cost list without logic.
  @override
  List<SupplyAmountTuple> fetchCurrentSupplyCosts() {
    return costs;
  }
}
