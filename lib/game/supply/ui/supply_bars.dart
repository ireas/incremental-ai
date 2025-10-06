import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:incremental_ai/game/supply/enum/supply_type.dart';
import 'package:incremental_ai/game/supply/model/supply_model.dart';
import 'package:incremental_ai/game/supply/supply_repository.dart';
import 'package:incremental_ai/game/supply/ui/supply_bar.dart';

class SupplyBars extends StatelessWidget {
  const SupplyBars({super.key});

  @override
  Widget build(BuildContext context) {
    Map<SupplyType, SupplyModel> models = GetIt.I<SupplyRepository>().models;

    return Column(spacing: 5, children: models.values.map((model) => SupplyBar(model: model)).toList());
  }
}
