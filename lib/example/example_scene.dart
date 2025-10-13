import 'package:flutter/material.dart';
import 'package:incremental_ai/game/quest/ui/quest_overview.dart';
import 'package:incremental_ai/game/routine/ui/routine_buttons.dart';
import 'package:incremental_ai/game/supply/ui/supply_bars.dart';

class ExampleScene extends StatelessWidget {
  const ExampleScene({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: double.infinity,
      child: Row(
        children: [
          Expanded(flex: 2, child: Container(child: SupplyBars())),
          Expanded(
            flex: 5,
            child: Column(children: [RoutineButtons()]),
          ),
          Expanded(flex: 2, child: Align(alignment: AlignmentGeometry.topCenter, child: QuestOverview())),
        ],
      ),
    );
  }
}
