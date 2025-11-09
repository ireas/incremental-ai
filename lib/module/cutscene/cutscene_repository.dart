import 'package:get_it/get_it.dart';
import 'package:incremental_ai/engine/archetype/repository/repository_archetype.dart';
import 'package:incremental_ai/engine/utility/has_update.dart';
import 'package:incremental_ai/module/cutscene/model/cutscene/cutscene_model.dart';

/// Repository class for Cutscene module.
class CutsceneRepository extends RepositoryArchetype with HasUpdate {
  /// Singleton instance.
  static CutsceneRepository get instance => GetIt.I<CutsceneRepository>();

  /// Queue of coming cutscenes.
  final List<CutsceneModel> queue = [];

  /// Currently shown cutscene.
  CutsceneModel? _current;

  CutsceneModel? get current => _current;

  set current(CutsceneModel? value) {
    _current = value;
    notifyListeners();
  }

  @override
  Future<void> initializeModels() async {}

  @override
  void update(double deltaTime) {
    // if no cutscene is active and queue is not empty, update current value
    if (current == null && queue.isNotEmpty) {
      current = queue.removeAt(0);
    }
  }
}
