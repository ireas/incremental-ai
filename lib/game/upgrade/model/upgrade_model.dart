import 'package:flutter/foundation.dart';

class UpgradeModel extends ChangeNotifier {
  final String id;
  bool enabled = false;

  UpgradeModel({required this.id});

  void update(double deltaTime) {
    notifyListeners();
  }
}
