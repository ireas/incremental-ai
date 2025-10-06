import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:incremental_ai/engine/module/assembly.dart';
import 'package:incremental_ai/example/example_scene.dart';
import 'package:incremental_ai/game/routine/enum/routine_type.dart';
import 'package:incremental_ai/game/routine/usecase/routine_modify_usecase.dart';
import 'package:incremental_ai/game/supply/enum/supply_type.dart';
import 'package:incremental_ai/game/supply/usecase/supply_modify_usecase.dart';
import 'package:logger/logger.dart';

/// Main application entry point
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Logger.level = Level.trace;

  await Assembly().assemble();

  // TODO: MOVE THIS TO A SEPARATE FILE FOR INITIAL GAME STARTS WITHOUT LOADING GAME SAVE
  GetIt.I<SupplyModifyUsecase>().enable(SupplyType.mana);
  GetIt.I<SupplyModifyUsecase>().enable(SupplyType.scrap);
  GetIt.I<RoutineModifyUsecase>().enable(RoutineType.collectScrap);

  runApp(MyApp());
}

// TODO: MOVE THIS TO SEPARATE ENGINE CLASS FOR RAPPING THE GAME
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlueAccent)),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return ExampleScene();
  }
}
