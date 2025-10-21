import 'package:flutter/foundation.dart';
import 'package:incremental_ai/game/supply/action/supply_amount_actions.dart';
import 'package:incremental_ai/game/supply/component/supply_amount_tuple.dart';
import 'package:incremental_ai/game/upgrade/model/upgrade/upgrade_state.dart';
import 'package:incremental_ai/game/upgrade/model/upgrade/upgrade_type.dart';

/// Base model for upgrades.
abstract class UpgradeModel extends ChangeNotifier {
  /// Unique type per model variant.
  final UpgradeType type;

  /// Current state of the upgrade.
  UpgradeState _state = UpgradeState.locked;

  UpgradeState get state => _state;

  /// The maximum number of times the upgrade can be purchased.
  /// If set to -1, disables the limit.
  final int maximumNumberOfPurchases;

  /// The number of times the player has successfully purchased this upgrade.
  int _numberOfPurchases = 0;

  int get numberOfPurchases => _numberOfPurchases;

  /// Constructor.
  UpgradeModel({required this.type, required this.maximumNumberOfPurchases});

  /// Updates the model.
  void update() {
    _automaticStateChange();
    notifyListeners();
  }

  /// Try purchasing the model with checks.
  void purchase() {
    // if upgrade is not purchasable, skip
    if (_state != UpgradeState.unlockedAndPurchasable) {
      return;
    }

    // pay all upgrade costs
    _paySupplyCosts();

    // increment purchase counter and check if it was the final allowed purchase
    _numberOfPurchases++;
    if (_numberOfPurchases == maximumNumberOfPurchases) {
      _state = UpgradeState.completelyPurchased;
    }

    // trigger variant effect
    onPurchase();
  }

  /// Checks and triggers automatic [state] changes.
  ///
  /// Automatic state changes are only allow if upgrade is one of these status
  /// - [UpgradeState.unlockedButNotPurchasable]
  /// - [UpgradeState.unlockedAndPurchasable]
  void _automaticStateChange() {
    // check state
    if (_state == UpgradeState.locked || _state == UpgradeState.completelyPurchased) {
      return;
    }

    // check if all supply costs can be paid
    for (SupplyAmountTuple cost in fetchCurrentSupplyCosts()) {
      // if any supplies are not sufficient, upgrade not purchasable
      if (!SupplyAmountActions.instance.hasSufficient(cost)) {
        _state = UpgradeState.unlockedButNotPurchasable;
        return;
      }
    }

    // upgrade is purchasable
    _state = UpgradeState.unlockedAndPurchasable;
  }

  /// Pays the current supply costs of upgrade, should be called when this upgrade is purchased.
  void _paySupplyCosts() {
    for (SupplyAmountTuple cost in fetchCurrentSupplyCosts()) {
      SupplyAmountActions.instance.subtract(cost);
    }
  }

  /// Unlocks the upgrade if currently locked.
  void unlock() {
    if (_state != UpgradeState.locked) {
      return;
    }
    // first assume not purchasable, will be updated on next update
    _state = UpgradeState.unlockedButNotPurchasable;
  }

  /// Returns current supply costs for upgrade.
  List<SupplyAmountTuple> fetchCurrentSupplyCosts();

  /// Effect that is triggered after upgrade purchase, determined per variant.
  void onPurchase();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UpgradeModel &&
          runtimeType == other.runtimeType &&
          _state == other._state &&
          maximumNumberOfPurchases == other.maximumNumberOfPurchases &&
          _numberOfPurchases == other._numberOfPurchases;

  @override
  int get hashCode => Object.hash(_state, maximumNumberOfPurchases, _numberOfPurchases);
}
