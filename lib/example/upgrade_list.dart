import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:incremental_ai/game/upgrade/upgade_ui.dart';
import 'package:incremental_ai/game/upgrade/upgrade_manager.dart';

class UpgradeList extends StatelessWidget {
  const UpgradeList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: GetIt.I<UpgradeManager>().models.values.map((upgrade) => UpgradeButton(source: upgrade)).toList());
  }
}
