import 'package:flutter/material.dart';

/// Material theme extension for colors.
class ThemeColors extends ThemeExtension<ThemeColors> {
  final Color backgroundDark;
  final Color backgroundMedium;
  final Color panelDark;
  final Color panelMedium;
  final Color panelLight;
  final Color text;
  final Color textMuted;
  final Color highlight;

  /// Constructor.
  const ThemeColors({
    required this.backgroundDark,
    required this.backgroundMedium,
    required this.panelDark,
    required this.panelMedium,
    required this.panelLight,
    required this.text,
    required this.textMuted,
    required this.highlight,
  });

  @override
  ThemeColors copyWith({
    Color? backgroundDark,
    Color? backgroundMedium,
    Color? panelDark,
    Color? panelMedium,
    Color? panelLight,
    Color? text,
    Color? textMuted,
    Color? highlight,
  }) {
    return ThemeColors(
      backgroundDark: backgroundDark ?? this.backgroundDark,
      backgroundMedium: backgroundMedium ?? this.backgroundMedium,
      panelDark: panelDark ?? this.panelDark,
      panelMedium: panelMedium ?? this.panelMedium,
      panelLight: panelLight ?? this.panelLight,
      text: text ?? this.text,
      textMuted: textMuted ?? this.textMuted,
      highlight: highlight ?? this.highlight,
    );
  }

  @override
  ThemeColors lerp(ThemeExtension<ThemeColors>? other, double t) {
    if (other is! ThemeColors) return this;
    return ThemeColors(
      backgroundDark: Color.lerp(backgroundDark, other.backgroundDark, t)!,
      backgroundMedium: Color.lerp(backgroundMedium, other.backgroundMedium, t)!,
      panelDark: Color.lerp(panelDark, other.panelDark, t)!,
      panelMedium: Color.lerp(panelMedium, other.panelMedium, t)!,
      panelLight: Color.lerp(panelLight, other.panelLight, t)!,
      text: Color.lerp(text, other.text, t)!,
      textMuted: Color.lerp(textMuted, other.textMuted, t)!,
      highlight: Color.lerp(highlight, other.highlight, t)!,
    );
  }
}

/// Add theme colors to build context for easier access.
extension ThemeColorsExtension on BuildContext {
  ThemeColors get colors => Theme.of(this).extension<ThemeColors>()!;
}
