import 'package:flutter/material.dart';
import 'package:incremental_ai/game/supply/model/supply/base/supply_model.dart';
import 'package:incremental_ai/game/supply/model/supply/supply_type.dart';

/// Scrap supply.
class ScrapSupplyModel extends SupplyModel {
  ScrapSupplyModel({super.type = SupplyType.scrap, super.color = Colors.amberAccent});
}
