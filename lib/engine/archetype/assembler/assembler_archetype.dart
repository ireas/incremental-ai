import 'package:incremental_ai/engine/archetype/assembler/supports_action.dart';
import 'package:incremental_ai/engine/archetype/assembler/supports_repository.dart';
import 'package:incremental_ai/engine/utility/has_validation.dart';
import 'package:incremental_ai/engine/utility/loggable.dart';

/// Abstract assembler base class that should be extended by each modules assembler.
abstract class AssemblerArchetype with Loggable {
  /// Initializes a module by assembling all of its component in the following order:
  /// - repository
  /// - action
  /// - validation
  Future<void> init() async {
    // initialize repository
    if (this is SupportsRepository) {
      await (this as SupportsRepository).assembleRepositories();
    }
    // initialize action
    if (this is SupportsAction) {
      await (this as SupportsAction).assembleActions();
    }
    // validate module
    if (this is HasValidation) {
      (this as HasValidation).validate();
    }
  }
}
