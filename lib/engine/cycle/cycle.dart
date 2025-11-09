import 'package:incremental_ai/engine/cycle/clock.dart';

/// Game loop class that can be started and executes all registered onTick methods each game tick.
class Cycle {
  /// Determines how often [_onTickMethods] should be called per seconds.
  static const int _ticksPerSecond = 10;

  /// Game loop clock.
  late final CycleClock _cycleClock;

  /// List of all methods that are called each in any order each tick.
  final List<void Function(double)> _onTickMethods;

  /// Constructor.
  Cycle({required List<void Function(double)> onTickMethods}) : _onTickMethods = onTickMethods {
    _cycleClock = CycleClock(_ticksPerSecond, _onTick);
  }

  /// Wraps all [_onTickMethods] into one and calls them each tick.
  void _onTick(double deltaTime) {
    for (void Function(double) onTickMethod in _onTickMethods) {
      onTickMethod.call(deltaTime);
    }
  }

  /// Starts the game loops cycle.
  void start() {
    _cycleClock.start();
  }
}
