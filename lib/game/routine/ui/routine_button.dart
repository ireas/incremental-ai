import 'package:flutter/material.dart';
import 'package:incremental_ai/game/routine/model/routine_model.dart';
import 'package:incremental_ai/game/routine/routine_manager.dart';
import 'package:watch_it/watch_it.dart';

class RoutineButton extends WatchingWidget {
  final RoutineModel model;

  const RoutineButton({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    RoutineModel current = watch<RoutineModel>(model);

    return TextButton(
      onPressed: () => GetIt.I<RoutineManager>().increment(current.id),
      child: Text("${current.id} Level: ${current.level}"),
    );
  }
}
