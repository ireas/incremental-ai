# Routine Module

The **Routine** module provides routines that can be activated and deactivated to trigger various effects. To use routines, sufficient
processing units must be available. This provides some decision-making for the player.

> [!NOTE]
> *Additional ideas...*
> - might want to add different categories of routines (permanent change, change on each tick, change after interval,...)
> - implement subroutines: passive routines that are weaker but do not require processing units

## Models

- **Routine**: a routine is a activatable component that has an activation level. Each routine triggers timed effects which increase in
  potency for higher activation levels. Activating and increasing the level requires reserving processing units for that routine.
- **Processor**: the processor model is a singular model that describes currently available and maximum available processing units.
  Processing units are not spend but reserved and can be freed when reducing routine activation levels.
