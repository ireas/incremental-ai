import 'package:flutter/material.dart';
import 'package:incremental_ai/game/supply/enum/supply_type.dart';
import 'package:incremental_ai/game/supply/model/supply_model.dart';

class ManaSupplyModel extends SupplyModel {
  static const SupplyType sourceType = SupplyType.mana;
  static const Color sourceColor = Colors.cyan;

  ManaSupplyModel({super.type = sourceType, super.color = sourceColor});
}
