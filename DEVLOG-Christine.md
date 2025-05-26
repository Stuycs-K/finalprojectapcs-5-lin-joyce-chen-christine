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

**!!!** Fix bug where both players can not move/aim/act at the same time **!!!**
