import 'package:get_it/get_it.dart';
import 'package:incremental_ai/engine/module/module_repository.dart';
import 'package:incremental_ai/game/notification/model/notification/notification_model.dart';

/// Repository of Notification module.
class NotificationRepository extends ModuleRepository {
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
  void validate() {
    // no validation needed since there are no initial notifications
  }

  @override
  void update(double deltaTime) {
    // if current model id empty, get oldest entry from models
    if (current == null && models.isNotEmpty) {
      current = models.removeAt(0);
    }
  }
}
