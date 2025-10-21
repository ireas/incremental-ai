# Upgrade Module

The `upgrade` module provides permanent improvement that the player can strive for. To purchase an upgrade, the player must pay certain
amount of costs. 
Upgrades are one of the main progression ways, especially in the early game.

> [!NOTE]
> Additional Ideas...
> - add images to upgrades UI
> - add infinite upgrades where costs are non-constant

## Models

The module contains only one type of model. However, it has multiple presets for different usages.

- **Upgrade**: can be purchased to trigger positive effects for the player
    - *Single Upgrade*: this preset can be purchased only one time, used for one-time unlocks or similar
    - *Multi Upgrade*: this preset can be bought multiple - but finite - times, used for incremental upgrades
