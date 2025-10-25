import 'package:flutter/material.dart';

/// Layout footer that is displayed on bottom of the screen.
class LayoutFooter extends StatelessWidget {
  final Widget child;

  /// Constructor.
  const LayoutFooter({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(child: child);
  }
}
