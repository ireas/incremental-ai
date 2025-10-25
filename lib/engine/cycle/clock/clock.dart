import 'dart:async';

/// Game loop clock that updates the game state on regular time intervals.
class CycleClock {
  /// Determines how many ticks per second the game loop clock executes.
  final int frequency;

  /// Reference to the last method call.
  DateTime _lastTime = DateTime.now();

  /// Method that gets invoked every game tick.
  /// The methods must contain one double argument for the delta time since last method execution.
  final void Function(double) onTick;

  /// Constructor.
  CycleClock(this.frequency, this.onTick);

  /// Starts the clock as internal periodic timer.
  void start() {
    // convert frequency into a time interval for timer
    Duration interval = Duration(milliseconds: (1e3 / frequency).round());

    _lastTime = DateTime.now();
    Timer.periodic(interval, (timer) {
      // calculate delta time and update timestamp
      final now = DateTime.now();
      final deltaTime = now.difference(_lastTime).inMilliseconds / 1e3;
      _lastTime = now;

      // call onTick method with delta time
      onTick(deltaTime);
    });
  }
}
