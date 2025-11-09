import 'package:flutter_fullscreen/flutter_fullscreen.dart';
import 'package:incremental_ai/engine/assembly/assembly.dart';
import 'package:incremental_ai/engine/cycle/cycle.dart';
import 'package:incremental_ai/engine/translator/translator.dart';
import 'package:incremental_ai/engine/utility/loggable.dart';

/// Game engine wrapper that setups all necessary classes to run UI-based games with modular content.
class Engine with Loggable {
  /// Starts the game engine.
  Future<void> start() async {
    // TODO: make this a toggle options and move to separate file
    // start fullscreen
    await FullScreen.ensureInitialized();
    FullScreen.setFullScreen(false);

    // prepare translator
    await Translator().init();

    // create all game modules in assembly
    Assembly assembly = Assembly();
    await assembly.assemble();

    // create game cycle, attach all methods and start
    Cycle cycle = Cycle(onTickMethods: assembly.fetchOnTickMethods());
    cycle.start();
  }
}
