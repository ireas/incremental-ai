import 'package:get_it/get_it.dart';
import 'package:incremental_ai/engine/archetype/assembler/assembler_archetype.dart';
import 'package:incremental_ai/engine/archetype/assembler/supports_action.dart';
import 'package:incremental_ai/engine/archetype/assembler/supports_repository.dart';
import 'package:incremental_ai/engine/utility/has_update.dart';
import 'package:incremental_ai/module/notification/action/notification_actions.dart';
import 'package:incremental_ai/module/notification/notification_repository.dart';

/// Assembler for Notification module.
class NotificationAssembler extends AssemblerArchetype with SupportsRepository, SupportsAction, HasUpdate {
  @override
  Future<void> assembleRepositories() async {
    NotificationRepository repository = NotificationRepository();
    await repository.initializeModels();
    GetIt.I.registerSingleton<NotificationRepository>(repository);
  }

  @override
  Future<void> assembleActions() async {
    GetIt.I.registerSingleton<NotificationActions>(NotificationActions());
  }

  @override
  void update(double deltaTime) {
    NotificationRepository.instance.update(deltaTime);
  }
}
