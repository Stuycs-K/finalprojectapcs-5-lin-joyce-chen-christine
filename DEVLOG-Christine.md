# Dev Log:

This document must be updated daily every time you finish a work session.

## Christine Chen

### 2025-05-23 - Implemented Core Gampeplay Mechanics
Worked for 2.1 hours. Completed platforms class (miscommunication! Joyce did this too) and added collision mechanics for players and projectile bouncing. Fixed + completed aiming logic and displayed aiming direction (need to work on controls/convenience of changing directions and with 2 players). Added reload cooldown for shooting and 2-player controls.

### 2025-05-24 - Tuned Aiming/Jumping + Bug Fixing
Worked for 40 minutes. Changed aiming to switch directions upon movement, limited aiming range, and adjusted player 2 to face player 1. Adjusted jump values and base jump. Fixed indexOutofBounds error when one player dies by adding boolean flag instead of removing from ArrayList.

Future Improvements: Platform clipping feels too fast, possibly perserve aim modifications when turning, tuning bullet bounces, working on sprites.

### 2025-05-25 - Drew Sprites/BG + More Game Tuning
Worked for 2.5 hours. Completed drawing walking + idle sprites with mouth open/closed for initial cat (Joyce turned them into gifs)! Drew and added background image (may change). Modified aiming/shooting to start from mouth area of cat sprite. Improved platform snapping in y-direction by adding vertical margin. Fixed duplication bug upon game end by adding boolean checks to prevent game state from updating.

Future Improvements:
- Possibly allow for horizontal jump charging (ex: holding w and d together will lead to jumping to the right)
- Possibly adding bar to display jump charges
- Allow bounces of bullets shot by player to damage that player?
- Work on image for Versus button
- Improve background image

**!!!** Fix bug where both players can not move/aim/act at the same time **!!!**. **!!** Fix bug where aiming controls are flipped upon changing direction **!!**.

### 2025-05-26 - Bug Fixing + Tuned Platform Clipping/Jumps
Worked for 2 hours. Modified input to track keys using boolean arrays p1Keys and p2Keys to fix simultaneous movement bug in Versus mode. Modified checkHit() to allow bullets to damage all players after bouncing. Adjusted vertical movement in applyMovement() to check incremental changes through while loop to prevent players from falling through platforms at higher speeds. Tuned jump/jump charging values and logic. Modified xMargin logic to ignore excess space on sides of hitbox for idle animation.

Future Improvements: Remove excess space on top of hitbox for both animations. Work on jumping animation. Work with Joyce in class tomorrow on boss mode and other ideas!!

### 2025-05-27 - Boss Mode
Worked for 2.5 hours. Created Boss class and began working on the boss phases we discussed during class! Implemented a beam attack pattern with alternating cycles and constant damage over time using damageCD to prevent too frequent hits. Implemented player trapping mechanic requiring 10 key presses to break free. Wrote a figure-8 teleportation method using the leminscate of Bernoulli formula for boss movements. Displayed boss visually and updated background/platforms to match Versus mode. Created template for an immune phase where the boss shoots projectiles in all directions and inverse player controls.

Future Improvements:
- Excess hitbox height (transparent part) leads to beams dealing damage when visually underneath it; fix hitbox or change beam logic
- Complete immune phase and fix boss positioning
- Fix bug where jump charge bar is stuck/filled when not jumping (find out why this happens!)

### 2025-05-28 - Drew Boss Sprite + More Boss Mode
Worked for 2 hours. Completed second boss phase with flashing white outline to indicate immunity + projectiles shot in circular pattern. Modified player projectiles to deal damage to boss in checkHit() and boss projectiles to deal damage to players with damage cooldown. Implemented inverse controls mechanic during boss fight. Displayed HP bar above boss which moves to bottom of boss when near top of screen. Drew and applied sprite for boss.

Future Improvements:
- Crop transparent part of image to fix hitbox height errors for cat1 sprite
- Modify bullets during immune phase for better gameplay experience
- Add projectiles to third phase of boss (teleporation phase)
- Fix boss positioning and interaction with platforms
- Defeat/Victory screens in Boss Mode

### 2025-05-29 - Enhanced Boss Moves + Bug Fixing
Worked for 1.5 hours. Added new beam patterns in first boss phase and applied damage for each. Modified lengths for each phase. Wrote code to remove boss projectiles from ArrayList once off-screen. Fixed bug causing players to sink through bottom platform after crouching. Integrated flower beam attack/visuals during immune phase and applied damage. Constrained lower limit for boss HP to mantain format of HP bar.

Future Improvements:
- Modify platform positions for Boss Mode
- Include s/DOWN keys to function as sneak button (decrease hitbox height + movement speed)
- Tune difficulty of Boss Mode

**!!!** Fix bug where grenades bring boss to negative lives in 1 hit **!!!**.

### 2025-05-30 - Graphics/Tuning + Bug Fixing
Worked for 2 hours. Improved graphics and text display warnings for trapped and inverse controls state in Boss Mode. Moved boss to rest on top of platform; moved aim line to match mouth area. Modified shootTick to decrease animation speed for shooting and decreased base movement/bullet speed. Fixed bug where falling off platform + releasing jump concurrently leads to jump charge becoming stuck. Reset jump bar/crouching after trapped state in Boss Mode and fixed bug where holding same key counts as spamming when escaping from trap. Drew basic outline for Alien Cat and Bomber Cat sprites.  

Future Improvements:
- Finish drawing Alien and Bomber Cat sprites
- Weekend To-Do list with Joyce!!

### 2025-05-31 - Character Selection Screen + Drew Sprites
Worked for 2.1 hours. Completed drawing sprites for Alien Cat. Modified code to improve memory efficiency when loading in sprites and lives. Added a character selection screen with previews/descriptions and keypress navigation + selection. Removed former character additions and spawned new objects of the selected character at correct positions. Complated drawing sprites for Bomber Cat.

Future Improvements:
- Clear Boss Mode or modify it so I can!!
- ~~Finish everything by Monday 8:33 A.M. (!!!!!!!)~~
  - Note: (We thought the entire project was due at that time!!)

**!!!** Update README **!!!**.

### 2025-06-01 - Graphics/SFX + README; Code Reformatting
Worked for 2.8 hours. Drew dark version background and displayed it during Boss immune phase along with warning signs. Updated README with Project Description and information regarding charcter selection, keyboard controls, and game mechanics. Added import for Processing sound effect library and added sound effects to players for shooting (my brother voiced it!) and receiving damage. Fixed tiny style interference bug from Character Selection. Drew loading screen to replace grey loading screen in Processing and reformatted code to load assets after loading screen. Created separate method to load game state to prevent loading assets multiple times. Added restart game method to replace former logic and fixed new bugs in restarting/exiting game. Fixed tiny bug regarding trying to pause audio when not playing any.

Future Improvements:
- Fix ArrayIndexOutOfBoundsException: Index 65406 (or similar) out of bounds for length 256 (find out why it happens!)
- Improve grenade logic for Bomber Cat
- Implement additional features (ex: revive system)

### 2025-06-02 - Bug Fixing + Mouse Aiming
Worked for 50 minutes. Fixed array index out of bounds error by adding proper bounds checks for spamKeys array. Increased volume for shooting sound and fixed logic for adjusting Boss BGM volume. Implemented aiming with mouse for single player and allowed for using either keyboard/mouse. Fixed bugs with grenade behavior by adding offset to spawn position + preventing them from bouncing backward and from falling through platforms.

Future Improvements:
- Adjust character/bullet speeds for better gameplay experience
- Add more sound effects to Boss Mode  

### 2025-06-03 - Demo Mode + Revive Feature
Worked for 40 minutes. Added Demo Mode with toggle button displayed in player # selection screen for Boss Mode. Changed number of lives to 33 for 1 Player Mode and 15 to 2 Player Mode in Demo Boss Mode. Slowed down death animation for 2 Player Boss Mode to implement revive feature requiring 5 presses of jump key when hitboxes are overlapping. Fixed bugs with new feature; dislayed text to indicate revivable state.

Future Improvements:
- Draw new BG for other maps: google doc list!

### 2025-06-04 - Bug Fixing + Drew New BG
Worked for 45 minutes. Fixed style interference leading to aim line not properly showing. Fixed revivable text constantly displaying + used spamKeys to prevent key holds counting as presses. Fixed status displays still showing upon death and increased death animation speed when both players are dead in 2 Player Boss Mode. Drew new background for Versus Mode, changed variables to match.

Future Improvements:
- Implement Map Selection screen
- Increase volume for shooting SFX
- Adjust new BG saturation/colors

### 2025-06-05 - Map Selection/Graphics + Falling Feature
Worked for 1.7 hours. Added map selection screen for Versus Mode with previews. Applied chosen map as background and created new platform layout with gaps in bottom platform. Allowed for falling off screen and repawning with -1 life. Drew background 3 and created another new platform layout. Implemented option to choose random map + question mark image display. Increased volume for shooting SFX. Added invincibility frames after falling off map with white flashing indicator lines. Drew new cloud platform and applied to map 3; moved platform loading to loadAssets() for better performance/memory efficiency.

Future Improvements:
- Fix Boss Mode BGM playing upon resetting game in both modes
- SFX for falling off map
- Make cloud platforms look less odd!! Also make Map3 less difficult

### 2025-06-05 - Bug Fixing +
Worked for _ + 10 minutes. Fixed bug with decreased hitboxes in mini mode leading to characters falling through platforms when jumping.

To-Do List:
- Fix bug with jump animation not displaying before mini mode
- Fix hitbox not reverting properly after mini mode

Future-Improvements:
