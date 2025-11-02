import 'package:flutter/material.dart';
import 'package:incremental_ai/game/supply/model/supply/base/supply_model.dart';
import 'package:incremental_ai/game/supply/model/supply/supply_type.dart';

/// Mana supply.
class ManaSupplyModel extends SupplyModel {
  ManaSupplyModel({super.type = SupplyType.mana, super.color = const Color.fromARGB(255, 21, 47, 91)});
}
