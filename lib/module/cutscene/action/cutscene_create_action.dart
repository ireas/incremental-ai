import 'package:get_it/get_it.dart';
import 'package:incremental_ai/module/cutscene/cutscene_repository.dart';
import 'package:incremental_ai/module/cutscene/model/cutscene/cutscene_model.dart';
import 'package:incremental_ai/engine/archetype/action/action_archetype.dart';

/// Actions creating cutscenes.
class CutsceneCreateAction extends ActionArchetype {
  /// Singleton instance.
  static CutsceneCreateAction get instance => GetIt.I<CutsceneCreateAction>();

  /// Sets the current cutscene model
  void create(CutsceneModel model) {
    CutsceneRepository.instance.queue.add(model);
  }
}
