# Incremental AI

An incremental UI-based video game using [Flutter](https://flutter.dev/) as game engine and UI framework.

## Technical Details

For service loading and state management, the project uses [flutter_it](https://flutter-it.dev/).

## Convention

Overview of internally used namings, to make them consistent.

### Concepts

- **engine**: General framework for UI-based games. Should be generalized and thus, usable by any (UI-based) game. It provides the basis for
  concepts
  like a game loop but done not add any content.
- **game**: Everything that includes content for this game should be part of the game directory.
- **module**: I mostly self-contained part of the game. Each module should consistent of logic, data and UI elements. Each module has an own
  folder. When deleting a folder, only dependent modules are allowed to break.
- **shared**: Everything that is shared across multiple modules should be part of the shared directory.

### Module Classes

- **assembler**: Entry point for a module that initially constructs and wires all *model*, *repository* and *usecase* classes. Unavailable
  after assembly is complete.
- **repository**: Singleton class that instantiates *models*, available via *get_it* instance.
- **model**: Mutable data class that can be listened to by the UI. Gets created and hold by a *repository*. Acts as the single source of
  truth for the model. Complex models with custom logic can have custom model classes extending base funcitonality. Available via
  *repository*.
- **usecase**: Singleton class that holds logic for a specific use case. Instantiate by *repository* and called by *UI*, available via
  *get_it* instance.