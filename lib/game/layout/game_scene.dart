import 'package:flutter/material.dart';
import 'package:incremental_ai/engine/ui/layout/layout.dart';
import 'package:incremental_ai/game/notification/ui/notification_overview.dart';
import 'package:incremental_ai/game/quest/ui/quest_overview.dart';
import 'package:incremental_ai/game/routine/ui/routine_buttons.dart';
import 'package:incremental_ai/game/supply/ui/supply_bars.dart';
import 'package:incremental_ai/game/upgrade/ui/upgrade_overview.dart';

class GameScene extends StatelessWidget {
  const GameScene({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      header: Align(alignment: AlignmentGeometry.topCenter, child: QuestOverview()),
      left: SupplyBars(),
      mainLeft: RoutineButtons(),
      mainRight: UpgradeOverview(),
      footer: NotificationOverview(),
    );
  }
}
