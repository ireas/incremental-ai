import 'package:flutter/material.dart';
import 'package:incremental_ai/engine/management/management.dart';
import 'package:incremental_ai/example/example_scene.dart';
import 'package:logger/logger.dart';

/// Main application entry point
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Logger.level = Level.trace;

  await Management().initialize();

  runApp(MyApp());
}

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
