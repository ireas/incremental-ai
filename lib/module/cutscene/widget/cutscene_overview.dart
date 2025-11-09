import 'package:flutter/material.dart';
import 'package:incremental_ai/module/cutscene/cutscene_repository.dart';
import 'package:incremental_ai/module/cutscene/model/cutscene/cutscene_model.dart';
import 'package:incremental_ai/module/cutscene/widget/cutscene_ui.dart';
import 'package:watch_it/watch_it.dart';

/// Overlay Cutscene widget that is always in widget tree.
/// If the [CutsceneRepository] has any cutscene currently active, displays it.
class CutsceneOverview extends WatchingWidget {
  /// Constructor.
  const CutsceneOverview({super.key});

  @override
  Widget build(BuildContext context) {
    // watch repository and check for currently active cutscene
    CutsceneRepository repository = watch<CutsceneRepository>(CutsceneRepository.instance);
    CutsceneModel? cutsceneModel = repository.current;

    // hide if no cutscene is active
    if (cutsceneModel == null) {
      return Container();
    }

    // show cutscene overlay
    return CutsceneOverlay(model: cutsceneModel);
  }
}
