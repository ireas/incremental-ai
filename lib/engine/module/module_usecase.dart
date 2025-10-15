import 'package:logger/logger.dart';

/// Abstract usecase base class that should be extended by each modules usecase.
abstract class ModuleUsecase {
  // logging
  final Logger logger = Logger();
}
