# Dev Log:

This document must be updated daily every time you finish a work session.

## Joyce Lin

### 2025-05-22 - Started preliminary coding and creating skeletons - 3.5 hours
Started the coding on main game tab (catformers), Character Class and Projectile Class. Currently, horizontal movement works but is a little wonky, jumping works (will have to consider base jump power and other things), and projectiles can be created (destroyed after three bounces). Some code (like for aiming) remains untested.

### 2025-05-23 - Screens and checkHit - 2.5 hours
Finished coding checkHit and made it so that when a character reaches 0 lives, they are removed from the character arraylist. Very prelim startscreen has been created and a select mode screen has been implemented.

bugs + things to consider for next coding session
- after a character is removed fromn arrayList, any keypresses for player 2 leads to an indexOutofBounds error
- when projectiles hit some areas (like corners) of the platforms, they kinda get stuck and implode
- redecorate start screen to be more colorful and fit the theme (forest)

### 2025-05-24 - Graphics and Screens - 2.5 hours
Created graphics for start screen and created a singleplayer/two player selection screen. Imported images for idle sprites and made it so that when turning, the respective sprite is used (left vs right). An unclip method was implemented to stop the projectiles from imploding upon hitting platform corners.

things to consider for next coding session
- start creating a boss class (maybe leave for tuesday along with extra characters so planning can be done together)
- more graphics!! (animating walking and creating backgrounds + something for the platforms)
- start creating a victory/lose mechanic (maybe just have a pop up instead of changing the screen?)
