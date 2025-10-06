import 'package:flutter/material.dart';
import 'package:incremental_ai/game/supply/enum/supply_state.dart';
import 'package:incremental_ai/game/supply/model/supply_model.dart';
import 'package:watch_it/watch_it.dart';

class SupplyBar extends WatchingWidget {
  final SupplyModel model;

  const SupplyBar({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    SupplyModel current = watch<SupplyModel>(model);

    if (current.state == SupplyState.locked) {
      return SizedBox(height: 0);
    }

    return SizedBox(
      height: 40,
      child: Container(
        color: Colors.black12,
        child: Tooltip(
          message: "tooltip for ${current.id}",
          child: Align(
            alignment: AlignmentGeometry.centerLeft,
            child: LayoutBuilder(
              builder: (context, constraint) {
                return SizedBox(
                  height: 40,
                  width: constraint.maxWidth * (current.value / current.capacity).clamp(0, 1),
                  child: ColoredBox(color: current.color),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
