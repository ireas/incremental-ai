import 'package:get_it/get_it.dart';
import 'package:incremental_ai/engine/localization/action/localization_translate_action.dart';
import 'package:incremental_ai/engine/module/module_usecase.dart';
import 'package:incremental_ai/game/supply/model/supply/supply_type.dart';
import 'package:incremental_ai/game/supply/supply_repository.dart';

/// Actions for localized labels.
class SupplyLabelActions extends ModuleActions {
  static SupplyLabelActions get instance => GetIt.I<SupplyLabelActions>();

  String name(SupplyType type) {
    return LocalizationTranslateAction.instance.translate("supply.${type.name}.name");
  }

  String tooltip(SupplyType type) {
    return LocalizationTranslateAction.instance.translate("supply.${type.name}.tooltip");
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
