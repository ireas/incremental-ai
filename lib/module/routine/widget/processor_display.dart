import 'package:flutter/material.dart';
import 'package:incremental_ai/engine/translator/translator.dart';
import 'package:incremental_ai/module/routine/model/processor/processor_model.dart';
import 'package:incremental_ai/module/routine/routine_repository.dart';
import 'package:watch_it/watch_it.dart';

/// UI widget for displaying routine processing units.
class ProcessorDisplay extends WatchingWidget {
  /// Constructor.
  const ProcessorDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    // fetch current processor model
    ProcessorModel processor = watch<ProcessorModel>(RoutineRepository.instance.processorModel);
    String nameLabel = Translator.instance.translate("routine.processor.name");

    return Text("$nameLabel: ${processor.value}/${processor.capacity}");
  }
}
