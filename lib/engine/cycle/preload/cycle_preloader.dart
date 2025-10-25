import 'package:get_it/get_it.dart';
import 'package:incremental_ai/engine/cycle/preload/cycle_preloader_plugin.dart';

/// Preloader that allows effects to be initialized before the game loop clock starts.
/// Additional preloaded effects must be registered via a [CyclePreloaderPlugin].
///
/// Singleton managed by [GetIt].
class CyclePreloader {
  static CyclePreloader get instance => GetIt.I<CyclePreloader>();

  /// List of all registered plugins.
  final List<CyclePreloaderPlugin> _plugins = [];

  /// Registers a plugin to preload.
  /// Must be added before game loop preload starts, otherwise plugin gets ignored!
  void register(CyclePreloaderPlugin plugin) => _plugins.add(plugin);

  /// Preloads all registered plugins.
  /// Should be called before game loop clock starts.
  void preload() {
    for (CyclePreloaderPlugin plugin in _plugins) {
      plugin.preload();
    }
  }
}
