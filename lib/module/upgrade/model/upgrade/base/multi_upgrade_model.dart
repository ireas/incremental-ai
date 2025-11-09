import 'package:incremental_ai/module/supply/component/supply_amount_tuple.dart';
import 'package:incremental_ai/module/upgrade/model/upgrade/base/upgrade_model.dart';

/// Model preset for multi-purchase upgrades.
abstract class MultiUpgradeModel extends UpgradeModel {
  final List<List<SupplyAmountTuple>> costs;

  /// Constructor, requires [costs] for upgrade and limits [maximumNumberOfPurchases] to length of costs.
  MultiUpgradeModel({required super.type, required this.costs}) : super(maximumNumberOfPurchases: costs.length);

  /// Fetch costs related to current [numberOfPurchases].
  @override
  List<SupplyAmountTuple> fetchCurrentSupplyCosts() {
    return costs[numberOfPurchases];
  }
}
