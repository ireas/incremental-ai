import 'dart:ui';

import 'package:flutter/foundation.dart';

class SupplyModel extends ChangeNotifier {
  final String id;
  final Color color;
  bool enabled = false;
  double value = 0;
  double capacity = 1;
  double rate = 0;

  SupplyModel({required this.id, required this.color});

  void update(double deltaTime) {
    if (enabled) {
      value += (deltaTime * rate).clamp(0, capacity);
    }
    notifyListeners();
  }
}
