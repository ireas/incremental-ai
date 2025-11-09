import 'package:flutter/cupertino.dart';
import 'package:incremental_ai/engine/utility/loggable.dart';

/// Abstract repository base class that should be extended by each modules repository.
abstract class RepositoryArchetype extends ChangeNotifier with Loggable {
  /// Initialize all models and store in repository.
  Future<void> initializeModels();
}
