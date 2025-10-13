import 'package:get_it/get_it.dart';
import 'package:incremental_ai/engine/module/assembly.dart';
import 'package:incremental_ai/engine/module/module_assembler.dart';
import 'package:incremental_ai/game/routine/routine_repository.dart';
import 'package:incremental_ai/game/routine/usecase/routine_inspect_usecase.dart';
import 'package:incremental_ai/game/routine/usecase/routine_modify_usecase.dart';

class RoutineAssembler extends ModuleAssembler {
  @override
  Future<void> assemble(Assembly assembler) async {
    // repository
    RoutineRepository repository = RoutineRepository();
    repository.initializeModels();
    GetIt.I.registerSingleton<RoutineRepository>(repository);
    assembler.registry.add(repository);

    // usecases
    GetIt.I.registerSingleton<RoutineModifyUsecase>(RoutineModifyUsecase(repository));
    GetIt.I.registerSingleton<RoutineInspectUsecase>(RoutineInspectUsecase(repository));
  }
}
