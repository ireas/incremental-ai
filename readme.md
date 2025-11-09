# Incremental AI

An incremental UI-based video game using [**Flutter**](https://flutter.dev/) as game engine and UI framework.

_This project is mainly used to learn flutter and dart in a fun way while exploring a niche UI-focused game genre. It is not expected to be
profitable or even complete. Instead, it should be a playing ground to train my skills in software architecture, frontend designing and a
new programming language._

---

## Architecture

Overview of implemented components and internally used conventions to give a high-level overview of the architecture.

#### Engine

The game engine is the central framework that consists of generalized components that could be reused by any (UI-based) video game.
It does not add content to the game. Instead, it offers functionalities and enforces a consistent module-based architecture.

#### Modules

Each game feature is implemented in a module, allowing for modularized content creation. The modules contain game content or more specific
functionality that are not part of the generalized engine.

The following class archetypes are used in each module for consistency.

###### Assembler

Each module has exactly one assembler class that is used to assemble all other module classes (such as repository, actions, ...) and link
them as necessary.

###### Repository

The repository is a permanent holder of all models for that module. It is used to update all models in a centralised class per module and
can be watched in widget for overviews. Modules typically have one repository, but may have any number of repository if multiple separate
model types are in use.

###### Model

A model is a mutable data class that contains only logic that the model applies to itself (such as update per cycle). It models a content
entity of the game. Thus, a module can have any number of model and even different types of models.

###### Action

Actions are classes that contain one or more methods for a single use case. It is allowed to contain more complex logic and should be
used by other models for inter-modular communication. Modules can have any number of actions.

###### Widget

Widgets are all user interface classes that show logic to the user. They typically watch the repository or single models for displaying.
Models can have any number of widgets.

---

## Libraries

To simplify the development process, some flutter libraries where included. While I focus on learning and building my own tools, reinventing
the wheel too much is not expedient.

For service loading and state management, the project uses [**flutter_it**](https://flutter-it.dev/).

For animations, the [**flutter_animate**](https://pub.dev/packages/flutter_animate) is used.
