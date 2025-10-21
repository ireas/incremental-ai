import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';

/// Abstract repository base class that should be extended by each modules repository.
/// TODO: consider making this class a generic, to save boilerplate code
abstract class ModuleRepository extends ChangeNotifier {
  /// Logger provided to all.
  final Logger logger = Logger();

  /// Initialize all models and store in repository.
  Future<void> initializeModels();

  /// Validates models in repository.
  void validate();

  /// Regularly update module by game loop.
  /// The [deltaTime] parameter is the time in seconds since the last update call.
  void update(double deltaTime);
}
