import 'package:flutter/material.dart';
import 'package:incremental_ai/engine/widget/theme/theme_sizes.dart';

import 'theme_colors.dart';

/// Provider for general visual theme using Material as base.
class ThemeProvider extends StatelessWidget {
  /// Main game scene to be displayed with theme.
  final Widget child;

  /// Constructor.
  const ThemeProvider({required this.child}) : super(key: const Key("theme_provider"));

  /// TODO: consider adding light theme
  /// TODO: clean up this long method
  @override
  Widget build(BuildContext context) {
    // DEFINE THEMES
    final darkThemeColors = ThemeColors(
      backgroundDark: Color.fromARGB(255, 2, 2, 3),
      backgroundMedium: Color.fromARGB(255, 8, 8, 7),
      panelDark: Color.fromARGB(220, 2, 2, 2),
      panelMedium: Color.fromARGB(200, 25, 25, 25),
      panelLight: Color.fromARGB(200, 30, 30, 30),
      text: Color.fromARGB(255, 235, 235, 235),
      textMuted: Color.fromARGB(255, 200, 200, 200),
      highlight: Color.fromARGB(255, 33, 99, 96),
    );

    final darkThemeSizes = ThemeSizes(radius: 6);

    final darkTheme = ThemeData.dark().copyWith(
      extensions: [darkThemeColors, darkThemeSizes],
      textTheme: TextTheme(
        headlineSmall: TextStyle(fontSize: 16, color: darkThemeColors.text, fontWeight: FontWeight.bold),
        bodyMedium: TextStyle(fontSize: 14, color: darkThemeColors.textMuted),
      ),
      colorScheme: ColorScheme.fromSeed(seedColor: darkThemeColors.highlight),
    );

    // create material app
    return MaterialApp(
      // set theme defaults
      themeMode: ThemeMode.dark,
      theme: darkTheme,
      // hide debug banner
      debugShowCheckedModeBanner: false,
      // provide material theme to child
      home: Material(child: child),
    );
  }
}
