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

### 2025-05-25 - More Graphics and Screens!! - 2.5 hours
A victory screen was implemented to appear after a player dies in versus mode and pressing enter/return allows the player to return to the start screen. Additionally walking animations for cat1 has been imported and now appears when horizontal movement is detected.

things to consider for next coding session
- create a square that displays bullet cooldowns (a countdown and maybe have it greyed out before the countdown is over)
- hearts on the tops of the screen that displays remaining lives (get hit 3 times --> death)

### 2025-05-26 - Some bug fixing and features - 40 minutes
A jump bar was implemented so jump charge is displayed when the player starts jumping and the bug where up and down is inverted when the player flips while aiming was also fixed. A preliminary map for versus was created as well!

stuff for tomorrow's class!!
- start figuring out boss class!
- think about other cat types we can implement and the difference between them

### 2025-05-27 - New types of projectiles - 1.5 hours
Working on implementing a death animation as well as two new types of projectiles. A preliminary code for the homing bullets and the grenade bullets have been created.

for next sessionnn
- find stock explosion for death animation
- implement a new checkHit for grenade bullets
- stop grenades from bouncing backwards at certain angles when hitting floor

### 2025-05-28 - Projectiles and hitboxes - 3 hours
Homing and grenade projectiles were implemented for characters (still requires further testing). Character hitboxes were also fixed so that they are closer to the actual image of the character. Additionally preliminary optimizations to projectiles during boss immune phase were made and a potential projectile for teleporting/moving phase was implemented, though incomplete (both open to change).

things to consider for next coding session
- create an escape menu so that the game can either be restarted or ended before characters die
- make it so that when boss projectiles leave the screen, they are removed from ArrayList
- fix any collision errors with projectiles

### 2025-05-29 - Menu and Crouching - 1.5 hours
A menu system was implemented where when the player presses the space bar, they have the option to either exit the game or to restart the game they are currently in (pressing the spacebar again closes this). A preliminary crouching system was also implemented along with minor tweaks to boss phase to only begin after all projectiles have left the screen.

things to consider for next coding session
- make bullets leave faster after immune phase has ended!
- start implementing death system in boss where the dead character starts floating up slowly in a straight line (prereq for creating revive system)
- add the stock explosion to death animation in versus mode!

### 2025-05-30 - Animations and small tweaks - 3 hours
Death animation was completed and an explosion is set to play everytime a player dies in versus mode. An open mouth was added to appear everytime a player shoots (to both walking and idle animations). Small tweaks to the game, such as preliminary platform positions for boss mode and the moving of player 2's hp bar to the right, was made. Grenade impact bug is fixed and it was made so that when characters die, movement is not allowed.

- work on completing the weekend's to do list!!
- note for Christine: check how long the mouth stays open for both walking and idle sprites + adjust using shootTick if too fast/slow!! :)

### 2025-05-31 - Horizontal Jump and screens - 1.5 hours
Horizontal jump system was created so that when player is walking and jumps, it travels a horizontal distance. A loss and victory screen was also implemented to happen after game ends in boss mode.

stuff to do + consider for next session
- animate sprites
- add wall restrictions so horizontal jumping next to a wall doesn't send you into the wall
- increase jumping height for horizontal jump

### 2025-06-01 - Sprites, Bugs, and Extras - 5 hours
Fixed bug where horizontal jumps would lead to character jumping off the screen and imported the sprites (+ animations) for cat2 + cat3. An hp potion mechanic was implemented in boss mode so that players can recover some health (make gameplay hopefully easier?). A basic death animation for boss mode was also created. BGM for the startscreen was selected.

stuff to do + consider for next session
- get the bgm to fade out after you select a mode (maybe also add select sounds)
- import bgm for versus and boss modes
