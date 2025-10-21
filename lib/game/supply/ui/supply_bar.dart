import 'package:flutter/material.dart';
import 'package:incremental_ai/game/supply/model/supply/base/supply_model.dart';
import 'package:incremental_ai/game/supply/model/supply/supply_type.dart';
import 'package:incremental_ai/game/supply/supply_repository.dart';
import 'package:watch_it/watch_it.dart';

/// Bar showing the current amount of a single supply.
class SupplyBar extends WatchingWidget {
  final SupplyType type;

  /// Constructor.
  const SupplyBar({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    // watch model
    SupplyModel supply = watch<SupplyModel>(SupplyRepository.instance.fetch(type));

    // bar
    return SizedBox(
      height: 40,
      child: Container(
        color: Colors.black12,
        child: Tooltip(
          message: "tooltip for ${supply.id}",
          child: Align(
            alignment: AlignmentGeometry.centerLeft,
            child: LayoutBuilder(
              builder: (context, constraint) {
                return SizedBox(
                  height: 40,
                  width: constraint.maxWidth * (supply.amount / supply.capacity).clamp(0, 1),
                  child: ColoredBox(color: supply.color),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
