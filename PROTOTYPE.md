# Technical Details:

PERIOD 5

Joyce Lin, Christine Chen

Catformers

2D platformer shooter where 1-2 players control cat characters that shoot bouncing projectiles at one another. Players must navigate platforms, aim, and shoot in either Versus mode (2 players) or Boss mode (1 player).
- In Versus mode: Players share one keyboard and attempt to kill the other player by aiming and hitting them with their bullets (making use of angles and platforms). This is heavily based on the tanks game where you must traverse platforms and plan to defeat the other player. As an additional mechanic, different characters with different stats will be implemented (i.e. faster moving speed, faster projectile speed).
- In Boss mode: You will either be able to play in a singleplayer mode (one person on keyboard) or in a two player mode (two people share one keyboard). This will be heavily based on the game Cuphead where the players will battle a stationary boss, dodging attacks and traversing platforms around the boss as they go from phase to phase (where the boss will have different attack patterns and/or characteristics such as immunity to attacks). Again, different character selections can make differences to the ensuing gameplay.

## Critical Features
Versus mode (two characters shoot bullets at each other and can jump from platform to platform)
- you win by hitting the other person 2-3 times (implement through usage of a 'lives' variable in character class)
- bullets bounce (using previous orbs lab) and goes away after 3-4 bounces

Boss mode (1-2 characters fight a stationary boss (hp and damage scales on how many players) with multiple phases after reaching a certain health level while navigating platforms)
- you win by killing the boss and lose by everyone dying (character dies after being hit 1-2 times)

character selection (at least 3 total characters)
- will be added into an ArrayList of characters which will be updated based on who is alive or dead
- each character will feature a Pimage variable so that the character sprite may be displayed

characters hold down jump to jump higher
- vectors!!

start/end screen
- possibly their own classes

## Nice to Have Features
bgm + sound effects (cats possibly voiced by mr Ks cats with permission !!)

different backgrounds + maps (map selection screen or random map)

little storyline for boss mode -- fight smaller monsters before reaching Boss
- when you reach the end of the screen, you tp back to the left and map refreshes until you reach the boss (1-3 map changes?)

revive feature in boss mode when your character dies and your teammate is alive
- player must click jump (causing a double jump) upon reaching the constantly floating upwards 'soul' (resembling Cuphead's revive feature)


# Project Design

UML Diagrams and descriptions of key algorithms, classes, and how things fit together.

|  Key Stuff           |  description  |
| :-------------: | :-------: |
|  projectile class     |        |
|  character class     |          |
|  platform class     |         |
|  jump power class     |        



# Intended pacing:

How you are breaking down the project and who is responsible for which parts.

A timeline with expected completion dates of parts of the project. (CHANGE THIS!!!!!)
projectile class (include reload variable, bounce variable, and type variable ) + character class
platform class
