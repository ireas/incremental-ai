import 'package:flutter/material.dart';
import 'package:incremental_ai/game/supply/model/supply/base/supply_model.dart';
import 'package:incremental_ai/game/supply/model/supply/supply_type.dart';
import 'package:incremental_ai/game/supply/supply_repository.dart';
import 'package:watch_it/watch_it.dart';

/// Bar showing the current amount of a single supply.
/// TODO: add proper tooltip to supplies
class SupplyBar extends WatchingWidget {
  /// Target
  final SupplyType type;

  /// Constants
  static const double height = 30;
  static const Duration animationDuration = Duration(milliseconds: 500);

  /// Constructor.
  const SupplyBar({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    // watch model
    SupplyModel supply = watch<SupplyModel>(SupplyRepository.instance.fetch(type));

    // bar
    return SizedBox(
      height: height,
      child: Tooltip(
        message: "Tooltip for ${supply.id}",
        child: Stack(
          alignment: AlignmentGeometry.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.horizontal(right: Radius.circular(6)),
              ),
            ),
            Align(
              alignment: AlignmentGeometry.centerLeft,
              child: LayoutBuilder(
                builder: (context, constraint) {
                  return AnimatedContainer(
                    duration: animationDuration,
                    curve: Curves.easeOutExpo,
                    height: height,
                    width: constraint.maxWidth * (supply.amount / supply.capacity).clamp(0, 1),
                    decoration: BoxDecoration(
                      color: supply.color,
                      borderRadius: BorderRadius.horizontal(right: Radius.circular(6)),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsetsGeometry.only(left: 4, right: 4),
              child: Row(
                children: [
                  Expanded(child: Text(supply.type.name)),
                  Text("${supply.amount}/${supply.capacity}", textAlign: TextAlign.right),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
