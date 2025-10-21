import 'package:incremental_ai/game/supply/action/supply_capacity_actions.dart';
import 'package:incremental_ai/game/supply/component/supply_amount_tuple.dart';
import 'package:incremental_ai/game/supply/model/supply/supply_type.dart';
import 'package:incremental_ai/game/upgrade/model/upgrade/base/multi_upgrade_model.dart';
import 'package:incremental_ai/game/upgrade/model/upgrade/upgrade_type.dart';
import 'package:logger/logger.dart';

/// Increases scap capacity on purchase.
class ScrapMultiCapacityUpgrade extends MultiUpgradeModel {
  /// Constructor.
  ScrapMultiCapacityUpgrade()
    : super(
        type: UpgradeType.increaseMultiScrapCapacity,
        costs: [
          [SupplyAmountTuple(type: SupplyType.scrap, amount: 0.6)],
          [SupplyAmountTuple(type: SupplyType.scrap, amount: 0.6)],
          [SupplyAmountTuple(type: SupplyType.scrap, amount: 0.6)],
          [SupplyAmountTuple(type: SupplyType.scrap, amount: 0.6)],
        ],
      );

  @override
  void onPurchase() {
    Logger().w("purchase multi");
    SupplyCapacityActions.instance.increase(SupplyAmountTuple(type: SupplyType.scrap, amount: 1));
  }
}
