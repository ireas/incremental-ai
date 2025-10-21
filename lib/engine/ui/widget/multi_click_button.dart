import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Extended button that allows for detecting left and right clicks.
class MultiClickButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onLeftClick;
  final VoidCallback onRightClick;

  const MultiClickButton({super.key, required this.child, required this.onLeftClick, required this.onRightClick});

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (event) {
        if (event.kind == PointerDeviceKind.mouse) {
          if (event.buttons == kPrimaryButton) {
            onLeftClick();
          } else if (event.buttons == kSecondaryButton) {
            onRightClick();
          }
        }
      },
      child: child,
    );
  }
}
