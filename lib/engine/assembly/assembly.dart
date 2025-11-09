import 'package:incremental_ai/engine/archetype/assembler/assembler_archetype.dart';
import 'package:incremental_ai/engine/archetype/assembler/supports_post_assemble.dart';
import 'package:incremental_ai/engine/utility/has_update.dart';
import 'package:incremental_ai/module/cutscene/cutscene_assembler.dart';
import 'package:incremental_ai/module/notification/notification_assembler.dart';
import 'package:incremental_ai/module/quest/quest_assembler.dart';
import 'package:incremental_ai/module/routine/routine_assembler.dart';
import 'package:incremental_ai/module/supply/supply_assembler.dart';
import 'package:incremental_ai/module/upgrade/upgrade_assembler.dart';

/// The Assembly can be used to assemble each module.
/// It must hold a reference to each active module assembler.
class Assembly {
  /// List of assembler classes for each active module.
  /// Modules that are not listed here, will not be assembled and thus, are inactive.
  final List<AssemblerArchetype> _assembler = [
    SupplyAssembler(),
    RoutineAssembler(),
    QuestAssembler(),
    UpgradeAssembler(),
    NotificationAssembler(),
    CutsceneAssembler(),
  ];

  /// Assembles each module asynchronously. After this method is done, all active modules can be used.
  Future<void> assemble() async {
    // assemble all modules
    for (AssemblerArchetype assembler in _assembler) {
      await assembler.init();
    }

    // execute all post assemble methods
    for (AssemblerArchetype assembler in _assembler) {
      if (assembler is SupportsPostAssemble) {
        (assembler as SupportsPostAssemble).postAssemble();
      }
    }
  }

  /// Loads all onTick methods from active module that support updates.
  List<void Function(double)> fetchOnTickMethods() {
    return _assembler.whereType<HasUpdate>().map((e) => e.update).toList();
  }
}
