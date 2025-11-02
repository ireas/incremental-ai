import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:incremental_ai/engine/ui/button/multi_click_button.dart';
import 'package:incremental_ai/engine/ui/effect/shimmer_border.dart';
import 'package:incremental_ai/engine/ui/theme/theme_colors.dart';
import 'package:incremental_ai/game/notification/action/notification_actions.dart';
import 'package:incremental_ai/game/notification/model/notification/notification_model.dart';

/// Displays a single notification in UI.
/// Uses a stateful widget to properly handle animations in different states.
class NotificationPanel extends StatefulWidget {
  final NotificationModel notification;

  /// Constructor.
  const NotificationPanel({super.key, required this.notification});

  @override
  State<NotificationPanel> createState() => _NotificationPanel();
}

/// Notification panel state that tracks whether user has hover / clicked the notification.
///
/// New notification glow.
/// After hovering, the notification is marked as read and does not glow anymore.
/// When clicked, the notification is closed and removed from repository.
class _NotificationPanel extends State<NotificationPanel> {
  bool _isHoveredOnce = false;
  bool _isClickedOnce = false;

  @override
  Widget build(BuildContext context) {
    return MultiClickButton(
      // on click, move of screen and remove current notification from repository
      onLeftClick: () => setState(() {
        _isClickedOnce = true;
        Future.delayed(const Duration(milliseconds: 1000), () {
          NotificationActions.instance.closeCurrentNotification();
        });
      }),
      child: MouseRegion(
        // on hover, stop animation
        onEnter: (_) => setState(() => _isHoveredOnce = true),
        child: Animate(
          target: _isClickedOnce ? 0 : 1,
          // moves widget into screen at the beginning
          effects: [MoveEffect(begin: Offset(0, 100))],

          // visual glow effect for unread notifications
          child: ShimmerBorder(
            enabled: !_isHoveredOnce,
            colorShimmer: Colors.teal,
            child: Container(
              decoration: BoxDecoration(color: ThemeColors.backgroundPanel, borderRadius: BorderRadius.circular(4)),
              padding: const EdgeInsets.all(8),

              // actual notification content
              child: Row(
                mainAxisSize: MainAxisSize.min,
                spacing: 10,
                children: [
                  Icon(Icons.notifications, color: ThemeColors.text, size: 20),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.notification.title,
                        style: TextStyle(fontWeight: FontWeight.bold, color: ThemeColors.text),
                      ),
                      Text(widget.notification.message),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
