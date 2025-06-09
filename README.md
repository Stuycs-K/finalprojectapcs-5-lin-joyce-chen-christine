[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/YxXKqIeT)
# Project Description

*Catformers* is a 2D platformer-shooter game where 1-2 players control cat characters (Catformers) who leap across platforms and fire bouncing projectiles. Players can select from several unique Catformers with diverse abilities and engage in fast-paced, action-packed combat across multiple game modes.

# Intended usage:

After launching and entering *Catformers*, players are prompted to choose between two game modes: **Versus Mode** and **Boss Mode**.

- In **Versus Mode**, two players compete to deplete each other's lives through strategic movements and precise shots——the last Catformer standing wins.
  - After selecting this mode, players will proceed to a **map selection screen**, where they can choose a themed background——each featuring an unique platform arrangement——or opt for a randomnized stage.
- In **Boss Mode**, players team up or play solo to defeat a powerful, multi-phase boss. Victory is achieved by reducing the boss's health to zero before all players are eliminated.
 - After selecting this mode, players are prompted to choose between **1-player** or **2-player co-op**.
 - Players also have the option to enable 2 toggles at the top right of the screen:
  1. **Demo Mode**: sets lives to **33 lives** in **1-player** and **15 lives** each in **2-player co-op**.
  2. **Story Mode**: adds narrative sequences to Boss Mode, featuring a platforming challenge, additional enemies, and a plotline attached to the boss fight.

Once all selections are made, players are taken to the **character selection screen**, where each player chooses their Catformer using the displayed keyboard controls.

During gameplay, all actions are controlled via the keyboard. The controls for each player are as follow:

### Controls

| Action                    | Player 1                   | Player 2 (if Versus / 2P Boss Mode) |
|---------------------------|----------------------------|-------------------------------------|
| Move Left                 | A                          | ←                                   |
| Move Right                | D                          | →                                   |
| Charge Jump               | Hold W, release to jump    | Hold ↑, release to jump             |
| Crouch                    | S                          | ↓                                   |
| Adjust Aim Angle ↑        | E (tilt aim upward)        | / (tilt aim upward)                 |
| Adjust Aim Angle ↓        | Q (tilt aim downward)      | , (tilt aim downward)               |
| Shoot                     | R                          | .                                   |

### Control Notes & Gameplay Mechanics

- **Charge Jump** displays a visible jump bar; the longer you hold before the bar maxes out, the higher you jump.
- **Crouch** reduces your hitbox and movement speed, allowing for dodging or precise movements.
- **Aiming** is reflected by a line coming from the Catformer's mouth. The aim angle never resets and each change must be made manually.
- **Shooting** is subject to a 1 second cooldown time.
  - **Projectiles** bounce 3 times off all walls, platforms, and the floor/ceiling before disapearing.
  - In **Boss Mode** friendly fire and self damage is disabled
  - In **Versus Mode**, players can take damage from their own projectiles if they bounce back.

## General UI & Game Features

**Pause Menu**: Press **SPACE** at any time during gameplay to pause the game.
From the pause screen, players can choose to:
- **Resume** (press SPACE again)
- **Restart** in the current game mode
- **Return** to Start Screen

**HP Indicator**:
- **Players** remaining lives are shown at the top of the screen as heart icons.
- **Boss** health bar is displayed above the boss' head.

### Boss Mode: Additional Mechanics

- **Traps** require players to spam keys 10 times to escape (shared in 2-Player Mode).
- **Inverse Controls** temporarily flip left/right movement and are indicated with an on-screen warning.

## Used Libraries

- **GIFs:** GifAnimation (Patrick M., Jerome SC.)
- **BGM + SFX:** Sound (Processing Foundation)
