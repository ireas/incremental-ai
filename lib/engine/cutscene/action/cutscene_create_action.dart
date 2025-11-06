import 'package:get_it/get_it.dart';
import 'package:incremental_ai/engine/cutscene/cutscene_repository.dart';
import 'package:incremental_ai/engine/cutscene/model/cutscene/cutscene_model.dart';
import 'package:incremental_ai/engine/module/module_usecase.dart';

/// Actions creating cutscenes.
class CutsceneCreateAction extends ModuleActions {
  static CutsceneCreateAction get instance => GetIt.I<CutsceneCreateAction>();

  /// Sets the current cutscene model
  void create(CutsceneModel model) {
    CutsceneRepository.instance.queue.add(model);
  }
}
