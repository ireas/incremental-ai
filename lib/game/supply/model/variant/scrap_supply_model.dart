import 'package:flutter/material.dart';
import 'package:incremental_ai/game/supply/enum/supply_type.dart';
import 'package:incremental_ai/game/supply/model/supply_model.dart';

class ScrapSupplyModel extends SupplyModel {
  static const SupplyType sourceType = SupplyType.scrap;
  static const Color sourceColor = Colors.amberAccent;

  ScrapSupplyModel({super.type = sourceType, super.color = sourceColor});
}
