import 'package:flutter/material.dart';
import 'package:incremental_ai/game/quest/model/quest/base/quest_model.dart';
import 'package:incremental_ai/game/quest/model/quest/quest_state.dart';
import 'package:incremental_ai/game/quest/quest_repository.dart';
import 'package:incremental_ai/game/quest/ui/quest_ui.dart';
import 'package:watch_it/watch_it.dart';

/// UI Widget for all [QuestModel] that are stored in the [QuestRepository].
class QuestOverview extends WatchingWidget {
  /// Set of all states that should be visible in the UI.
  static const Set<QuestState> visibleStates = {QuestState.active};

  /// Constructor.
  const QuestOverview({super.key});

  /// Builds a list vertical list of all quests.
  @override
  Widget build(BuildContext context) {
    // watch the repository
    QuestRepository repository = watch<QuestRepository>(QuestRepository.instance);

    // vertical list of each visible upgrade button
    // TODO: properly show one main quest or tagged quest instead of just the "first"
    return Align(
      alignment: AlignmentGeometry.topRight,
      child: repository
          .fetchAll()
          .where((e) => visibleStates.contains(e.state))
          .map((e) => QuestUi(type: e.type))
          .toList()
          .first,
    );
  }
}
