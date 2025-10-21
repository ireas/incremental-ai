import 'package:flutter/material.dart';
import 'package:incremental_ai/game/supply/model/supply/supply_state.dart';
import 'package:incremental_ai/game/supply/supply_repository.dart';
import 'package:incremental_ai/game/supply/ui/supply_bar.dart';
import 'package:watch_it/watch_it.dart';

/// Vertical list that displays all currently unlocked supplies.
class SupplyBars extends WatchingWidget {
  /// Set of all states that should be visible in the UI.
  static const Set<SupplyState> visibleStates = {SupplyState.unlocked};

  /// Constructor.
  const SupplyBars({super.key});

  @override
  Widget build(BuildContext context) {
    // watch the repository
    SupplyRepository repository = watch<SupplyRepository>(SupplyRepository.instance);

    // vertical list of each visible upgrade button
    return Column(
      children: repository
          .fetchAll()
          .where((e) => visibleStates.contains(e.state))
          .map((e) => SupplyBar(type: e.type))
          .toList(),
    );
  }
}
