import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:incremental_ai/engine/localization/localization_assembler.dart';
import 'package:incremental_ai/engine/module/assembly.dart';
import 'package:incremental_ai/example/example_scene.dart';
import 'package:incremental_ai/game/quest/model/quest/variants/tutorial_collect_scrap_quest.dart';
import 'package:incremental_ai/game/quest/quest_repository.dart';
import 'package:logger/logger.dart';

/// Main application entry point
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Logger.level = Level.info;

  // TODO: MOVE THIS TO SEPARATE FILE
  LocalizationAssembler localizationAssembler = LocalizationAssembler();
  await localizationAssembler.assemble();

  // TODO: MOVE THIS TO SEPARATE FILE
  await Assembly().assemble();

  // TODO: MOVE THIS TO A SEPARATE FILE FOR INITIAL GAME STARTS WITHOUT LOADING GAME SAVE
  GetIt.I<QuestRepository>().fetch(TutorialCollectScrapQuest.sourceId)?.activate();

  runApp(MyApp());
}

// TODO: MOVE THIS TO SEPARATE ENGINE CLASS FOR RAPPING THE GAME
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: const TextTheme(bodyMedium: TextStyle(fontSize: 20, color: Colors.black87)),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlueAccent),
      ),
      home: Material(child: ExampleScene()),
      debugShowCheckedModeBanner: false,
    );
  }
}
