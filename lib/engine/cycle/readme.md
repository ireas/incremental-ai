# Cycle

The **Cycle** describes the game loop. It consists of a periodic timer - the clock - that ticks a predefined number of time each seconds.
On each tick, a set of registered module methods is called to update the game state.

> [!IMPORTANT]
> The update speed on the clock is not directly related to the FPS of the game.
