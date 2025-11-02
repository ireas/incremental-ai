import 'package:flutter/material.dart';

/// Layout main content region that is horizontally split into two sub-regions, each must be filled with one child widget.
///
/// The flex values can be optionally set to customize relative size of regions.
class LayoutMain extends StatelessWidget {
  // CHILDREN
  final Widget leftChild;
  final Widget rightChild;

  // FLEX
  final int flexLeft;
  final int flexRight;

  /// Constructor.
  const LayoutMain({
    super.key,
    required this.leftChild,
    required this.rightChild,
    this.flexLeft = 50,
    this.flexRight = 50,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: flexLeft, child: leftChild),
        Expanded(flex: flexRight, child: rightChild),
      ],
    );
  }
}
