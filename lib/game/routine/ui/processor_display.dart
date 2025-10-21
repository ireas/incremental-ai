import 'package:flutter/material.dart';
import 'package:incremental_ai/engine/localization/usecase/localization_translate_usecase.dart';
import 'package:incremental_ai/game/routine/model/processor/processor_model.dart';
import 'package:incremental_ai/game/routine/routine_repository.dart';
import 'package:watch_it/watch_it.dart';

/// UI widget for displaying routine processing units.
class ProcessorDisplay extends WatchingWidget {
  /// Constructor.
  const ProcessorDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    // fetch current processor model
    ProcessorModel processor = watch<ProcessorModel>(RoutineRepository.instance.processorModel);
    String nameLabel = GetIt.I<LocalizationTranslateUsecase>().translate("routine.processor.name");

    return Text("$nameLabel: ${processor.value}/${processor.capacity}");
  }
}
