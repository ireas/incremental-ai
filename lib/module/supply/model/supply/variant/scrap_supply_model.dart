import 'package:flutter/material.dart';
import 'package:incremental_ai/module/supply/model/supply/base/supply_model.dart';
import 'package:incremental_ai/module/supply/model/supply/supply_type.dart';

/// Scrap supply.
class ScrapSupplyModel extends SupplyModel {
  ScrapSupplyModel({super.type = SupplyType.scrap, super.color = const Color.fromARGB(255, 99, 83, 20)});
}
