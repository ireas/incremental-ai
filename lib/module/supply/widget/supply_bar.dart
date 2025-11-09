import 'package:flutter/material.dart';
import 'package:incremental_ai/engine/widget/theme/theme_colors.dart';
import 'package:incremental_ai/engine/widget/theme/theme_sizes.dart';
import 'package:incremental_ai/module/supply/action/supply_label_actions.dart';
import 'package:incremental_ai/module/supply/model/supply/base/supply_model.dart';
import 'package:incremental_ai/module/supply/model/supply/supply_type.dart';
import 'package:incremental_ai/module/supply/supply_repository.dart';
import 'package:watch_it/watch_it.dart';

/// Bar showing the current amount of a single supply.
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
        message: SupplyLabelActions.instance.tooltip(type),
        child: Stack(
          alignment: AlignmentGeometry.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: context.colors.panelMedium,
                borderRadius: BorderRadius.horizontal(right: Radius.circular(context.sizes.radius)),
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
                      borderRadius: BorderRadius.horizontal(right: Radius.circular(context.sizes.radius)),
                    ),
                  );
                },
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: context.colors.panelLight, width: 1),
                  bottom: BorderSide(color: context.colors.panelLight, width: 1),
                  right: BorderSide(color: context.colors.panelLight, width: 1),
                ),
                borderRadius: BorderRadius.horizontal(right: Radius.circular(context.sizes.radius)),
              ),
            ),
            Padding(
              padding: EdgeInsetsGeometry.only(left: 4, right: 4),
              child: Row(
                children: [
                  Expanded(child: Text(SupplyLabelActions.instance.name(type))),
                  Text(
                    "${SupplyLabelActions.instance.amount(type)}/${SupplyLabelActions.instance.capacity(type)}",
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
