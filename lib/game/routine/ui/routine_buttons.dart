import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:incremental_ai/game/routine/model/routine/routine_model.dart';
import 'package:incremental_ai/game/routine/routine_repository.dart';
import 'package:incremental_ai/game/routine/ui/routine_button.dart';

/// UI widget that shows all routine models in simple column.
class RoutineButtons extends StatelessWidget {
  /// Constructor.
  const RoutineButtons({super.key});

  @override
  Widget build(BuildContext context) {
    // fetch all routine models
    Map<String, RoutineModel> models = GetIt.I<RoutineRepository>().models;

    return Column(children: models.values.map((model) => RoutineButton(model: model)).toList());
  }
}
