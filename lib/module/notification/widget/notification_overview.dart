import 'package:flutter/material.dart';
import 'package:incremental_ai/module/notification/model/notification/notification_model.dart';
import 'package:incremental_ai/module/notification/notification_repository.dart';
import 'package:incremental_ai/module/notification/widget/notification_panel.dart';
import 'package:watch_it/watch_it.dart';

/// Notification display, that shows the current active notification if there is any. Otherwise is empty container.
class NotificationOverview extends WatchingWidget {
  /// Constructor.
  const NotificationOverview({super.key});

  @override
  Widget build(BuildContext context) {
    // watch repository for any change
    NotificationRepository repository = watch<NotificationRepository>(NotificationRepository.instance);

    // fetch current notification
    NotificationModel? current = repository.current;

    // if no notification is active, show nothing
    if (current == null) {
      return Container();
    }

    // show notification centered, generate new key to properly update on change
    return Align(
      alignment: AlignmentGeometry.center,
      child: NotificationPanel(key: ObjectKey(current), notification: current),
    );
  }
}
