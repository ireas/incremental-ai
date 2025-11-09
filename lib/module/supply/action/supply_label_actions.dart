import 'package:get_it/get_it.dart';
import 'package:incremental_ai/engine/archetype/action/action_archetype.dart';
import 'package:incremental_ai/engine/translator/translator.dart';
import 'package:incremental_ai/module/supply/model/supply/supply_type.dart';
import 'package:incremental_ai/module/supply/supply_repository.dart';

/// Actions for *Additional ideas...*ed labels.
class SupplyLabelActions extends ActionArchetype {
  /// Singleton instance.
  static SupplyLabelActions get instance => GetIt.I<SupplyLabelActions>();

  String name(SupplyType type) {
    return Translator.instance.translate("supply.${type.name}.name");
  }

  String tooltip(SupplyType type) {
    return Translator.instance.translate("supply.${type.name}.tooltip");
  }

  String amount(SupplyType type) {
    // TODO: extract value formatting into separate globally available method
    double value = SupplyRepository.instance.fetch(type).amount;
    if (value.abs() >= 10) {
      return value.toStringAsPrecision(1);
    }
    return value.toStringAsPrecision(3);
  }

  String capacity(SupplyType type) {
    double value = SupplyRepository.instance.fetch(type).capacity;
    if (value.abs() >= 10) {
      return value.toStringAsPrecision(1);
    }
    return value.toStringAsPrecision(3);
  }
}
