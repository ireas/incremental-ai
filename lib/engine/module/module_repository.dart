import 'package:logger/logger.dart';

/// Abstract repository base class that should be extended by each modules repository.
abstract class ModuleRepository {
  // Logging
  final Logger logger = Logger();

  /// Initialize all models and store in repository.
  Future<void> initializeModels();

  /// Regularly update module by game loop.
  /// The [deltaTime] parameter is the time in seconds since the last update call.
  void update(double deltaTime);
}
