import 'package:flutter/material.dart';
import 'package:incremental_ai/engine/ui/panel/section_panel.dart';
import 'package:incremental_ai/game/quest/model/quest/base/quest_model.dart';
import 'package:incremental_ai/game/quest/model/quest/quest_type.dart';
import 'package:incremental_ai/game/quest/quest_repository.dart';
import 'package:watch_it/watch_it.dart';

/// UI Widget displaying a single [QuestModel].
class QuestUi extends WatchingWidget {
  final QuestType type;

  /// Constructor, requiring a model and allow for a custom widget key.
  const QuestUi({super.key, required this.type});

  /// Builds a simple widget showing quest name and (if active) its objective.
  @override
  Widget build(BuildContext context) {
    // watch current quest model for changes
    QuestModel quest = watch<QuestModel>(QuestRepository.instance.fetch(type));

    // active quest show details
    return SectionPanel(
      connectTop: true,
      connectRight: true,
      child: SizedBox(
        width: 500,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Text(quest.labelName, style: Theme.of(context).textTheme.headlineSmall),
            ),
            Column(
              children: quest.objectives
                  .map(
                    (objective) => Container(
                      padding: EdgeInsets.all(5),
                      alignment: Alignment.topLeft,
                      child: Text(objective.label, style: Theme.of(context).textTheme.bodyMedium),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
