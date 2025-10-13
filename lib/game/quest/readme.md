# Quest Module

The quest module provides challenges that the player needs to achieve and thus, provides a feel of progression.

## Models

- **Quest**: a quest is a composite model that consists of one or more _objectives_. They can trigger any action on activation, completion
  or fail. These are specialised to provide unique challenges.
- **Objectives**: an objective is a atomic task the player needs to achieve. These should be designed generalistic to be reusable in several
  quests.

> [!NOTE]
> Additional Ideas...
> - add timed quests for more urgency.
> - add quest line models for easier handling of multiple interconnected quests
> - improve visual layout and add broad and detailed view for quests