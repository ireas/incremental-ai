import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:incremental_ai/game/quest/model/quest/quest_model.dart';
import 'package:incremental_ai/game/quest/quest_repository.dart';
import 'package:incremental_ai/game/quest/ui/quest_ui.dart';

/// UI Widget for all [QuestModel] that are stored in the [QuestRepository].
class QuestOverview extends StatelessWidget {
  /// Constructor.
  const QuestOverview({super.key});

  /// Builds a list vertical list of all quests.
  /// TODO: fix that models are only loaded once and ALL models are shown here, consider dynamic approach.
  @override
  Widget build(BuildContext context) {
    // fetch list of all quest models once
    Map<String, QuestModel> models = GetIt.I<QuestRepository>().models;

    // show them with title
    return Column(
      children: [
        Text("Quests"),
        Column(spacing: 5, children: models.values.map((model) => QuestUi(model: model)).toList()),
      ],
    );
  }
}
