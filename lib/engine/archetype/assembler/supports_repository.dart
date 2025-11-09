/// Allows assemblers to setup repositories for a module.
/// Should only be implemented by [AssemblerArchetype] implementations.
mixin SupportsRepository {
  /// Setup all repositories for a module.
  Future<void> assembleRepositories();
}
