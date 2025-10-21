import 'package:flutter/material.dart';
import 'package:incremental_ai/engine/ui/widget/multi_click_button.dart';
import 'package:incremental_ai/game/upgrade/action/upgrade_label_action.dart';
import 'package:incremental_ai/game/upgrade/model/upgrade/base/upgrade_model.dart';
import 'package:incremental_ai/game/upgrade/model/upgrade/upgrade_state.dart';
import 'package:incremental_ai/game/upgrade/model/upgrade/upgrade_type.dart';
import 'package:incremental_ai/game/upgrade/upgrade_repository.dart';
import 'package:watch_it/watch_it.dart';

/// Button that displays a single upgrade, can be clicked to purchase upgrade.
class UpgradeButton extends WatchingWidget {
  final UpgradeType type;

  const UpgradeButton({required this.type, super.key});

  @override
  Widget build(BuildContext context) {
    // watch model
    UpgradeModel upgrade = watch<UpgradeModel>(UpgradeRepository.instance.fetch(type));

    // button
    return MultiClickButton(
      onLeftClick: () => upgrade.purchase(),
      onRightClick: () => (),
      child: SizedBox(
        height: 60,
        child: Tooltip(
          message: UpgradeLabelAction.instance.tooltipLabel(type),
          child: Container(
            color: upgrade.state == UpgradeState.unlockedAndPurchasable ? Colors.lightBlueAccent : Colors.grey,
            padding: EdgeInsets.all(5),
            child: Row(
              children: [
                Icon(Icons.question_mark, color: Colors.black87, size: 40),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: Text(UpgradeLabelAction.instance.nameLabel(type))),
                      Text(UpgradeLabelAction.instance.costLabel(type)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
