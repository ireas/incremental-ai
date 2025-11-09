/// Models a single notification.
class NotificationModel {
  /// Short notification title
  final String title;
  /// Long notification message
  final String message;

  /// Constructor.
  NotificationModel({required this.title, required this.message});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotificationModel && runtimeType == other.runtimeType && title == other.title && message == other.message;

  @override
  int get hashCode => Object.hash(title, message);
}
