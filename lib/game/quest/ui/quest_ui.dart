import 'package:flutter/material.dart';
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
    return Container(
      color: Colors.grey,
      padding: EdgeInsets.all(5),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(quest.labelName, style: TextStyle(fontSize: 15)),
          ),
          Container(
            padding: EdgeInsets.all(5),
            child: Column(
              children: quest.objectives
                  .map(
                    (objective) => Container(
                      padding: EdgeInsets.all(5),
                      alignment: Alignment.centerLeft,
                      child: Text(objective.label, style: TextStyle(fontSize: 12)),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
