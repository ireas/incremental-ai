import 'package:get_it/get_it.dart';
import 'package:incremental_ai/engine/module/assembly.dart';
import 'package:incremental_ai/engine/module/module_assembler.dart';
import 'package:incremental_ai/game/notification/action/notification_actions.dart';
import 'package:incremental_ai/game/notification/notification_repository.dart';

/// Assembler for Notification module.
class NotificationAssembler extends ModuleAssembler {
  @override
  Future<void> assemble(Assembly assembler) async {
    // repository
    NotificationRepository repository = NotificationRepository();
    await repository.initializeModels();
    repository.validate();
    GetIt.I.registerSingleton<NotificationRepository>(repository);
    assembler.registry.add(repository);

    // actions
    GetIt.I.registerSingleton<NotificationActions>(NotificationActions());
  }
}
