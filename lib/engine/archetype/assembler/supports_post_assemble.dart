import 'package:incremental_ai/engine/archetype/assembler/assembler_archetype.dart';

/// Allows assemblers to setup post assemble methods for a module that are called directly after all modules have been assembled.
/// Should only be implemented by [AssemblerArchetype] implementations.
mixin SupportsPostAssemble {
  /// Post assemble method that is called once after all modules were assembled.
  void postAssemble();
}
