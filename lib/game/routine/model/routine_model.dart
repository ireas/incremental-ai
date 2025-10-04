import 'package:flutter/cupertino.dart';

abstract class RoutineModel extends ChangeNotifier {
  final String id;
  bool enabled = false;
  int level = 0;

  RoutineModel({required this.id});

  void update(double deltaTime);
}
