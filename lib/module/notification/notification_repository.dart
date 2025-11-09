import 'package:get_it/get_it.dart';
import 'package:incremental_ai/engine/archetype/repository/repository_archetype.dart';
import 'package:incremental_ai/engine/utility/has_update.dart';
import 'package:incremental_ai/module/notification/model/notification/notification_model.dart';

/// Repository of Notification module.
class NotificationRepository extends RepositoryArchetype with HasUpdate {
  /// Singleton instance.
  static NotificationRepository get instance => GetIt.I<NotificationRepository>();

  /// Notification models are part of this queue which follows the FIFO principle.
  final List<NotificationModel> models = [];

  /// Current notification, will be used to pop queued notifications. Notifies watchers on change.
  NotificationModel? _current;

  NotificationModel? get current => _current;

  set current(NotificationModel? model) {
    _current = model;
    notifyListeners();
  }

  @override
  Future<void> initializeModels() async {
    // there are no initial notifications to setup
  }

  @override
  void update(double deltaTime) {
    // if current model id empty, get oldest entry from models
    if (current == null && models.isNotEmpty) {
      current = models.removeAt(0);
    }
  }
}
