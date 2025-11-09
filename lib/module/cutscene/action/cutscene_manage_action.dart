import 'package:get_it/get_it.dart';
import 'package:incremental_ai/module/cutscene/cutscene_repository.dart';
import 'package:incremental_ai/engine/archetype/action/action_archetype.dart';

/// Actions managing cutscenes.
class CutsceneManageAction extends ActionArchetype {
  /// Singleton instance.
  static CutsceneManageAction get instance => GetIt.I<CutsceneManageAction>();

  /// Removes the current cutscene from repository.
  void closeCurrentCutscene() {
    CutsceneRepository.instance.current = null;
  }
}
