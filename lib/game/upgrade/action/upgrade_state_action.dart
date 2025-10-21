import 'package:get_it/get_it.dart';
import 'package:incremental_ai/engine/module/module_usecase.dart';
import 'package:incremental_ai/game/upgrade/model/upgrade/upgrade_type.dart';
import 'package:incremental_ai/game/upgrade/upgrade_repository.dart';

/// Action regarding upgrade states.
class UpgradeStateAction extends ModuleUsecase {
  /// Singleton instance served by [GetIt].
  static UpgradeStateAction get instance => GetIt.I<UpgradeStateAction>();

  /// Unlocks the target upgrade identified by [type].
  void unlock(UpgradeType type) {
    UpgradeRepository.instance.fetch(type).unlock();
  }
}
