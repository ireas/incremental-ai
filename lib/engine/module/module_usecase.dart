import 'package:logger/logger.dart';

/// Actions base class that should be extended by each modules actions.
abstract class ModuleActions {
  /// Logger provided to all.
  final Logger logger = Logger();
}
