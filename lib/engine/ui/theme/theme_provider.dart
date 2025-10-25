import 'package:flutter/material.dart';

/// Provider for general visual theme using Material as base.
class ThemeProvider extends StatelessWidget {
  /// Main game scene to be displayed with theme.
  final Widget child;

  /// Constructor.
  const ThemeProvider({required this.child}) : super(key: const Key("theme_provider"));

  @override
  Widget build(BuildContext context) {
    // create material app
    return MaterialApp(
      // set theme defaults
      theme: ThemeData(
        textTheme: const TextTheme(bodyMedium: TextStyle(fontSize: 14, color: Colors.black87)),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlueAccent),
      ),
      // hide debug banner
      debugShowCheckedModeBanner: false,
      // provide material theme to child
      home: Material(child: child),
    );
  }
}
