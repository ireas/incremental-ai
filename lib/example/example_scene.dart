import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:incremental_ai/example/upgrade_list.dart';
import 'package:incremental_ai/game/routine/ui/routine_buttons.dart';
import 'package:incremental_ai/game/supply/supply_manager.dart';
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
              child: Column(
                children: [
                  TextButton(
                    onPressed: () => GetIt.I<SupplyManager>().enable("supply.scrap"),
                    child: Text("Show Scrap Supply"),
                  ),
                  RoutineButtons(),
                  UpgradeList(),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
