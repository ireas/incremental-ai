import 'dart:ui';

import 'package:flutter/material.dart';

/// Material theme extension for sizes.
class ThemeSizes extends ThemeExtension<ThemeSizes> {
  final double radius;

  /// Constructor.
  const ThemeSizes({required this.radius});

  @override
  ThemeSizes copyWith({double? radius}) {
    return ThemeSizes(radius: radius ?? this.radius);
  }

  @override
  ThemeSizes lerp(ThemeExtension<ThemeSizes>? other, double t) {
    if (other is! ThemeSizes) return this;
    return ThemeSizes(radius: lerpDouble(radius, other.radius, t)!);
  }
}

/// Add theme sizes to build context for easier access.
extension ThemeSizesExtension on BuildContext {
  ThemeSizes get sizes => Theme.of(this).extension<ThemeSizes>()!;
}
