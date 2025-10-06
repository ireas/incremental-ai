import 'dart:async';

class Clock {
  /// how many ticks per second
  final int frequency;
  final void Function(double) onTick;
  DateTime _lastTime = DateTime.now();

  Clock(this.frequency, this.onTick);

  void start() {
    final interval = Duration(milliseconds: (1e3 / frequency).round());

    _lastTime = DateTime.now();
    Timer.periodic(interval, (timer) {
      final now = DateTime.now();
      final delta = now.difference(_lastTime).inMilliseconds / 1e3;
      _lastTime = now;
      onTick(delta);
    });
  }
}
