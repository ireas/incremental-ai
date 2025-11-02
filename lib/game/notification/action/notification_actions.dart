import 'package:get_it/get_it.dart';
import 'package:incremental_ai/engine/module/module_usecase.dart';
import 'package:incremental_ai/game/notification/model/notification/notification_model.dart';
import 'package:incremental_ai/game/notification/notification_repository.dart';

/// Actions to add or remove notifications from queue.
class NotificationActions extends ModuleActions {
  static NotificationActions get instance => GetIt.I<NotificationActions>();

  /// Adds another notification to queue.
  void addNotificationToQueue(NotificationModel notification) {
    NotificationRepository.instance.models.add(notification);
  }

  /// Discards the current shown notification.
  void closeCurrentNotification() {
    NotificationRepository.instance.current = null;
  }
}
