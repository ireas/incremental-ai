import 'package:incremental_ai/engine/module/module_usecase.dart';
import 'package:incremental_ai/game/supply/enum/supply_type.dart';
import 'package:incremental_ai/game/supply/supply_repository.dart';

class SupplyInspectUsecase extends ModuleUsecase {
  final SupplyRepository repository;

  SupplyInspectUsecase(this.repository);

  /// Fetches current value, targets model with set [type].
  double value(SupplyType type) {
    return repository.fetch(type).value;
  }
}
