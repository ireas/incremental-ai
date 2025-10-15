import 'dart:math';

import 'package:flutter/foundation.dart';

/// Model that represents processors used for routine activation.
class ProcessorModel extends ChangeNotifier {
  /// Current number of available processors units.
  int _value = 0;

  /// Current maximum capacity of processor units.
  int _capacity = 0;

  /// Constructor.
  ProcessorModel();

  /// Getter for [_value];
  int get value => _value;

  /// Getter for [_capacity];
  int get capacity => _capacity;

  /// Only allow value in range from 0 to [_capacity].
  set value(int newValue) {
    _value = newValue.clamp(0, _capacity);
    notifyListeners();
  }

  /// Only allow capacity greater than 0.
  set capacity(int newCapacity) {
    _capacity = max(0, newCapacity);
    notifyListeners();
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProcessorModel && runtimeType == other.runtimeType && _capacity == other._capacity;

  @override
  int get hashCode => _capacity.hashCode;
}
