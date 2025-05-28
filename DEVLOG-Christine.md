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

### 2025-05-28 -
Worked for ... Completed second boss phase with flashing white outline to indicate immunity and projectiles shot in circular pattern. Modified player projectiles to deal damage to boss in checkHit(). Implemented (inverse controls ...)
