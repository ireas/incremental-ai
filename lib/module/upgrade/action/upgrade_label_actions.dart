import 'package:get_it/get_it.dart';
import 'package:incremental_ai/engine/archetype/action/action_archetype.dart';
import 'package:incremental_ai/engine/translator/translator.dart';
import 'package:incremental_ai/module/upgrade/model/upgrade/upgrade_type.dart';
import 'package:incremental_ai/module/upgrade/upgrade_repository.dart';

/// Action regarding upgrade labels.
class UpgradeLabelActions extends ActionArchetype {
  /// Singleton instance.
  static UpgradeLabelActions get instance => GetIt.I<UpgradeLabelActions>();

  /// Returns the name label for upgrade specified by [type] parameter.
  /// For multi-purchase upgrade, add the current number of purchases to name.
  String nameLabel(UpgradeType type) {
    String name = Translator.instance.translate("upgrade.${type.name}.name");

    // add current level for multi-purchase upgrades
    if (UpgradeRepository.instance.fetch(type).maximumNumberOfPurchases > 1) {
      name = "$name (${UpgradeRepository.instance.fetch(type).numberOfPurchases})";
    }

    return name;
  }

  /// Returns the tooltip label for upgrade specified by [type] parameter.
  String tooltipLabel(UpgradeType type) {
    return Translator.instance.translate("upgrade.${type.name}.tooltip");
  }

  /// Returns the costs label for upgrade specified by [type] parameter.
  String costLabel(UpgradeType type) {
    return UpgradeRepository.instance
        .fetch(type)
        .fetchCurrentSupplyCosts()
        .map((e) => "${e.amount} ${e.type.name}")
        .toList()
        .join(", ");
  }
}
