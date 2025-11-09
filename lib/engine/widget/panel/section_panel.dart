import 'package:flutter/material.dart';
import 'package:incremental_ai/engine/widget/theme/theme_colors.dart';
import 'package:incremental_ai/engine/widget/theme/theme_sizes.dart';

/// General panel that wraps a section.
class SectionPanel extends StatelessWidget {
  /// Child that is displayed in panel.
  final Widget? child;

  // determine which edges have no separation or border
  final bool connectTop;
  final bool connectBottom;
  final bool connectLeft;
  final bool connectRight;

  // determines which inner paddings are ignored
  final bool skipInnerTop;
  final bool skipInnerBottom;
  final bool skipInnerLeft;
  final bool skipInnerRight;

  /// Constructor.
  const SectionPanel({
    super.key,
    required this.child,
    this.connectTop = false,
    this.connectBottom = false,
    this.connectLeft = false,
    this.connectRight = false,
    this.skipInnerTop = false,
    this.skipInnerBottom = false,
    this.skipInnerLeft = false,
    this.skipInnerRight = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // add padding to edges that are not skipped
      padding: EdgeInsetsGeometry.only(
        top: connectTop ? 0 : 10,
        bottom: connectBottom ? 0 : 10,
        left: connectLeft ? 0 : 10,
        right: connectRight ? 0 : 10,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: context.colors.panelDark,
          // add border to edges that are not skipped
          border: Border(
            top: connectTop ? BorderSide.none : BorderSide(color: context.colors.panelLight, width: 1),
            bottom: connectBottom ? BorderSide.none : BorderSide(color: context.colors.panelLight, width: 1),
            left: connectLeft ? BorderSide.none : BorderSide(color: context.colors.panelLight, width: 1),
            right: connectRight ? BorderSide.none : BorderSide(color: context.colors.panelLight, width: 1),
          ),
          // add rounded corners to edges that are not skipped
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(connectTop || connectLeft ? 0 : context.sizes.radius),
            topRight: Radius.circular(connectTop || connectRight ? 0 : context.sizes.radius),
            bottomLeft: Radius.circular(connectBottom || connectLeft ? 0 : context.sizes.radius),
            bottomRight: Radius.circular(connectBottom || connectRight ? 0 : context.sizes.radius),
          ),
        ),
        padding: EdgeInsetsGeometry.only(
          top: skipInnerTop ? 0 : 20,
          bottom: skipInnerBottom ? 0 : 20,
          left: skipInnerLeft ? 0 : 20,
          right: skipInnerRight ? 0 : 20,
        ),
        child: child,
      ),
    );
  }
}
