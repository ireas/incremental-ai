import 'package:flutter/material.dart';
import 'package:incremental_ai/game/upgrade/model/upgrade_model.dart';
import 'package:incremental_ai/game/upgrade/upgrade_manager.dart';
import 'package:watch_it/watch_it.dart';

class UpgradeButton extends WatchingWidget {
  final UpgradeModel source;

  const UpgradeButton({super.key, required this.source});

  @override
  Widget build(BuildContext context) {
    UpgradeModel watched = watch<UpgradeModel>(source);

    String msg = "Upgrade: ${watched.id}";
    if (!watched.enabled) {
      msg += " (disabled)";
    }

    return TextButton(onPressed: () => GetIt.I<UpgradeManager>().enable(watched.id), child: Text(msg));
  }
}
