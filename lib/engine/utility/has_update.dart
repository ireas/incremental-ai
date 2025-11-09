/// Allows for a update method in cycle, is not called automatically.
mixin HasUpdate {
  /// Update method called on every update tick.
  /// Here, [deltaTime] is the time difference since last method call in seconds.
  void update(double deltaTime);
}
