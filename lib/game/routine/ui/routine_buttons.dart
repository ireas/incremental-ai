import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:incremental_ai/game/routine/model/routine_model.dart';
import 'package:incremental_ai/game/routine/routine_manager.dart';
import 'package:incremental_ai/game/routine/ui/routine_button.dart';

class RoutineButtons extends StatelessWidget {
  const RoutineButtons({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, RoutineModel> models = GetIt.I<RoutineManager>().models;

    return Column(children: models.values.map((model) => RoutineButton(model: model)).toList());
  }
}
