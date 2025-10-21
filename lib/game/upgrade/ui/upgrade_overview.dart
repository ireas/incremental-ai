import 'package:flutter/material.dart';
import 'package:incremental_ai/game/upgrade/model/upgrade/upgrade_state.dart';
import 'package:incremental_ai/game/upgrade/ui/upgrade_button.dart';
import 'package:incremental_ai/game/upgrade/upgrade_repository.dart';
import 'package:watch_it/watch_it.dart';

/// Vertical list that displays all currently unlocked (and not purchased) upgrades.
class UpgradeOverview extends WatchingWidget {
  /// Set of all states that should be visible in the UI.
  static const Set<UpgradeState> visibleStates = {
    UpgradeState.unlockedButNotPurchasable,
    UpgradeState.unlockedAndPurchasable,
  };

  /// Constructor.
  const UpgradeOverview({super.key});

  @override
  Widget build(BuildContext context) {
    // watch the repository
    UpgradeRepository repository = watch<UpgradeRepository>(UpgradeRepository.instance);

    // vertical list of each visible upgrade button
    return Column(
      children: repository
          .fetchAll()
          .where((e) => visibleStates.contains(e.state))
          .map((e) => UpgradeButton(type: e.type))
          .toList(),
    );
  }
}
