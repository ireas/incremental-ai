import 'package:flutter/material.dart';
import 'package:incremental_ai/game/routine/enum/routine_state.dart';
import 'package:incremental_ai/game/routine/model/routine_model.dart';
import 'package:incremental_ai/game/routine/usecase/routine_modify_usecase.dart';
import 'package:watch_it/watch_it.dart';

class RoutineButton extends WatchingWidget {
  final RoutineModel model;

  const RoutineButton({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    RoutineModel current = watch<RoutineModel>(model);

    if (current.state == RoutineState.locked) {
      return SizedBox(height: 0);
    }

    return TextButton(
      onPressed: () => GetIt.I<RoutineModifyUsecase>().increment(current.type),
      child: Text("${current.id} Level: ${current.level}"),
    );
  }
}
