import 'package:incremental_ai/module/supply/action/supply_capacity_actions.dart';
import 'package:incremental_ai/module/supply/component/supply_amount_tuple.dart';
import 'package:incremental_ai/module/supply/model/supply/supply_type.dart';
import 'package:incremental_ai/module/upgrade/model/upgrade/base/single_upgrade_model.dart';
import 'package:incremental_ai/module/upgrade/model/upgrade/upgrade_type.dart';
import 'package:logger/logger.dart';

/// Increases scap capacity on purchase.
class ScrapCapacityUpgrade extends SingleUpgradeModel {
  /// Constructor.
  ScrapCapacityUpgrade()
    : super(
        type: UpgradeType.increaseScrapCapacity,
        costs: [
          SupplyAmountTuple(type: SupplyType.scrap, amount: 1),
          SupplyAmountTuple(type: SupplyType.mana, amount: 2),
        ],
      );

  @override
  void onPurchase() {
    Logger().w("purchase");
    SupplyCapacityActions.instance.increase(SupplyAmountTuple(type: SupplyType.scrap, amount: 3));
  }
}
