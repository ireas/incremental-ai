import 'package:flutter/material.dart';

/// Layout main content region that is horizontally split into three sub-regions, each must be filled with one child widget.
///
/// The flex values can be optionally set to customize relative size of regions.
class LayoutMain extends StatelessWidget {
  // CHILDREN
  final Widget leftChild;
  final Widget centerChild;
  final Widget rightChild;

  // FLEX
  final int flexLeft;
  final int flexCenter;
  final int flexRight;

  /// Constructor.
  const LayoutMain({
    super.key,
    required this.leftChild,
    required this.centerChild,
    required this.rightChild,
    this.flexLeft = 20,
    this.flexCenter = 60,
    this.flexRight = 20,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: flexLeft,
          child: Container(child: leftChild),
        ),
        Expanded(
          flex: flexCenter,
          child: Container(child: centerChild),
        ),
        Expanded(
          flex: flexRight,
          child: Container(child: rightChild),
        ),
      ],
    );
  }
}
