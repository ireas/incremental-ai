# Incremental AI

An incremental UI-based video game using [Flutter](https://flutter.dev/) as game engine and UI framework.

For service loading and state management, the project uses [flutter_it](https://flutter-it.dev/).

## Convention

Overview of internally used namings, to make them consistent.

### Concepts

- **engine**: General framework for UI-based games. Should be generalized and thus, usable by any (UI-based) game. It provides the basis for
  concepts
  like a game loop but done not add any content.
- **game**: Everything that includes content for this game should be part of the game directory.
- **module**: I mostly self-contained part of the game. Each module should consistent of logic, data and UI elements. Each module has an own
  folder.
- **common**: Everything that is shared across multiple modules should be part of the shared directory.

### Module Classes

- **assembler**: entry point for a module that initially constructs and wires all *model*, *repository* and *usecase* classes, unavailable
  after assembly is complete.
- **repository**: singleton class that instantiates *models*
- **model**: mutable data class that can be listened to by the UI. Gets created and hold by a *repository*. Acts as the single source of
  truth for the model.
    - _abstract base_ models should contain all common logic and extendable hook methods.
    - _concrete variant_ models implement logic overrides for specific implementations used in the game
- **actions**: singleton class that holds actions and aggregated logic for specific use cases. Instantiate by *assembler* and called by any
  component.