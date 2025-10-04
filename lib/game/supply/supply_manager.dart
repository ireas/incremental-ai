import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:incremental_ai/engine/management/manager.dart';
import 'package:incremental_ai/game/supply/config/supply_config.dart';
import 'package:incremental_ai/game/supply/config/supply_config_loader.dart';
import 'package:incremental_ai/game/supply/model/supply_model.dart';
import 'package:logger/logger.dart';

class SupplyManager extends Manager {
  static final Logger _logger = Logger();
  late final Map<String, SupplyModel> models;
  late final SupplyConfig config;

  SupplyManager() {
    GetIt.I.registerSingleton<SupplyManager>(this);
  }

  @override
  Future<void> initialize() async {
    // load config
    config = await SupplyConfigLoader().load();

    // initialize models
    models = {};
    models["supply.mana"] = SupplyModel(id: "supply.mana", color: Colors.cyan);
    models["supply.scrap"] = SupplyModel(id: "supply.scrap", color: Colors.brown);
  }

  void enable(String id) {
    _logger.t("Enabling $id");
    SupplyModel? model = models[id];

    if (model == null) {
      _logger.w("$id mot found");
      return;
    }

    model.enabled = true;
  }

  void increaseValue(String id, double value) {
    _logger.t("Increasing value for $id");
    SupplyModel? model = models[id];

    if (model == null) {
      _logger.w("$id mot found");
      return;
    }

    model.value += value;
  }

  @override
  void onUpdate(double deltaTime) {
    for (SupplyModel model in models.values) {
      model.update(deltaTime);
    }
  }
}
