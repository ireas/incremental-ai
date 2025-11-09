import 'package:get_it/get_it.dart';
import 'package:incremental_ai/engine/archetype/action/action_archetype.dart';
import 'package:incremental_ai/module/upgrade/model/upgrade/upgrade_type.dart';
import 'package:incremental_ai/module/upgrade/upgrade_repository.dart';

/// Action regarding upgrade states.
class UpgradeStateActions extends ActionArchetype {
  /// Singleton instance.
  static UpgradeStateActions get instance => GetIt.I<UpgradeStateActions>();

  /// Unlocks the target upgrade identified by [type].
  void unlock(UpgradeType type) {
    UpgradeRepository.instance.fetch(type).unlock();
  }
}
