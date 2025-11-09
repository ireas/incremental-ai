import 'package:flutter/material.dart';
import 'package:incremental_ai/module/layout/layout.dart';
import 'package:incremental_ai/module/notification/widget/notification_overview.dart';
import 'package:incremental_ai/module/quest/widget/quest_overview.dart';
import 'package:incremental_ai/module/routine/widget/routine_buttons.dart';
import 'package:incremental_ai/module/supply/widget/supply_bars.dart';
import 'package:incremental_ai/module/upgrade/widget/upgrade_overview.dart';

/// High-level scene widget that describes which/where elements are shown in the UI.
class GameScene extends StatelessWidget {
  /// Constructor.
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
