import 'package:flutter/material.dart';
import 'package:incremental_ai/game/routine/ui/routine_buttons.dart';
import 'package:incremental_ai/game/supply/ui/supply_bars.dart';

class ExampleScene extends StatelessWidget {
  const ExampleScene({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        return Row(
          children: [
            SizedBox(
              width: 0.3 * constraint.maxWidth,
              child: Container(color: Colors.white, child: SupplyBars()),
            ),
            SizedBox(
              width: 0.7 * constraint.maxWidth,
              child: Column(children: [RoutineButtons()]),
            ),
          ],
        );
      },
    );
  }
}
