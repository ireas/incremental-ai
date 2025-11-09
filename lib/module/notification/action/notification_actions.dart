import 'package:get_it/get_it.dart';
import 'package:incremental_ai/engine/archetype/action/action_archetype.dart';
import 'package:incremental_ai/module/notification/model/notification/notification_model.dart';
import 'package:incremental_ai/module/notification/notification_repository.dart';

/// Actions to add or remove notifications from queue.
class NotificationActions extends ActionArchetype {
  /// Singleton instance.
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
