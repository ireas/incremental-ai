import 'package:flutter/material.dart';
import 'package:flutter_fullscreen/flutter_fullscreen.dart';
import 'package:incremental_ai/engine/localization/localization_assembler.dart';
import 'package:incremental_ai/engine/module/assembly.dart';
import 'package:incremental_ai/engine/ui/theme/theme_provider.dart';
import 'package:incremental_ai/game/layout/game_scene.dart';
import 'package:logger/logger.dart';

/// Main application entry point
Future<void> main() async {
  // set global flutter settings
  WidgetsFlutterBinding.ensureInitialized();
  Logger.level = Level.info;

  // TODO: make this a toggle options and move to separate file
  // start fullscreen
  await FullScreen.ensureInitialized();
  FullScreen.setFullScreen(false);

  // TODO: MOVE THIS TO SEPARATE FILE
  // prepare localization
  LocalizationAssembler localizationAssembler = LocalizationAssembler();
  await localizationAssembler.assemble();

  // TODO: MOVE THIS TO SEPARATE FILE
  // assemble game
  await Assembly().assemble();

  // start game
  runApp(ThemeProvider(child: GameScene()));
}
