import 'package:logger/logger.dart';

/// Abstract usecase base class that should be extended by each modules usecase.
abstract class ModuleUsecase {
  // Logging
  final Logger logger = Logger();
}
