import 'package:get_it/get_it.dart';
import 'package:incremental_ai/engine/localization/localization_repository.dart';
import 'package:incremental_ai/engine/localization/action/localization_current_language_action.dart';
import 'package:incremental_ai/engine/localization/action/localization_placeholder_action.dart';
import 'package:incremental_ai/engine/localization/action/localization_translate_action.dart';
import 'package:logger/logger.dart';

/// Assembler for the localization framework. Injects repository and usecases into GetIt.
class LocalizationAssembler {
  final Logger _logger = Logger();

  /// Initializes repository and injects GetIt singletons.
  Future<void> assemble() async {
    _logger.t("Assembling Localization");

    // assemble and register repository
    LocalizationRepository repository = LocalizationRepository();
    await repository.initialize();
    GetIt.I.registerSingleton<LocalizationRepository>(repository);

    // assemble and register usecases
    GetIt.I.registerSingleton<LocalizationCurrentLanguageAction>(LocalizationCurrentLanguageAction());
    GetIt.I.registerSingleton<LocalizationTranslateAction>(LocalizationTranslateAction());
    GetIt.I.registerSingleton<LocalizationPlaceholderAction>(LocalizationPlaceholderAction());

    // validate after assembly
    repository.validate();
  }
}
