import 'package:flutter/material.dart';
import 'package:incremental_ai/engine/engine.dart';
import 'package:incremental_ai/engine/widget/theme/theme_provider.dart';
import 'package:incremental_ai/module/layout/game_scene.dart';
import 'package:logger/logger.dart';

/// Main application entry point.
Future<void> main() async {
  // set global flutter settings
  WidgetsFlutterBinding.ensureInitialized();
  Logger.level = Level.info;

  // prepare the game engine and start game
  Engine engine = Engine();
  await engine.start();

  // start game
  runApp(ThemeProvider(child: GameScene()));
}
