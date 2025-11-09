import 'package:incremental_ai/engine/archetype/assembler/assembler_archetype.dart';

/// Allows assemblers to setup actions for a module.
/// Should only be implemented by [AssemblerArchetype] implementations.
mixin SupportsAction {
  /// Setup all actions for a module.
  Future<void> assembleActions();
}
