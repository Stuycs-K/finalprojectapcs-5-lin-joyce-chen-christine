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
Worked for 2 hours. Improved graphics and text display warnings for trapped and inverse controls state in Boss Mode. Moved boss to rest on top of platform; moved aim line to match mouth area. Modified shootTick to decrease animation speed for shooting and decreased base movement/bullet speed. Fixed bug where falling off platform + releasing jump concurrently leads to jump charge becoming stuck. Reset jump bar/crouching after trapped state in Boss Mode and fixed bug where holding same key counts as spamming when escaping from trap. Drew basic outline for alien cat and bomber cat sprites.  

Future Improvements:
- Finish drawing alien and bomber cat sprites
- Weekend To-Do list with Joyce!!
