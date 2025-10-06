import 'package:incremental_ai/engine/module/assembly.dart';
import 'package:logger/logger.dart';

/// Abstract assembler base class that should be extended by each modules assembler.
abstract class ModuleAssembler {
  // Logging
  final Logger logger = Logger();

  /// Constructs and wires module logic data and logic classes. Is called by given [assembler].
  Future<void> assemble(Assembly assembler);
}
