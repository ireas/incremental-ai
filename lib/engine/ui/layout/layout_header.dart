import 'package:flutter/material.dart';

/// Layout header that is displayed on top of the screen.
class LayoutHeader extends StatelessWidget {
  final Widget child;

  /// Constructor.
  const LayoutHeader({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
