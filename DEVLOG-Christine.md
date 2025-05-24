# Dev Log:

This document must be updated daily every time you finish a work session.

## Christine Chen

### 2025-05-23 - Implemented core gampeplay mechanics
Worked slightly more than 2 hours. Completed platforms class (miscommunication! Joyce did this too) and added collision mechanics for players and projectile bouncing. Fixed + completed aiming logic and displayed aiming direction (need to work on controls/convenience of changing directions and with 2 players). Added reload cooldown for shooting and 2-player controls.

### 2025-05-24 - Tuned aiming/jumping + bug fixing
Worked for 40 minutes. Changed aiming to switch directions upon movement, limited aiming range, and adjusted player 2 to face player 1. Adjusted jump values and base jump. Fixed indexOutofBounds error when one player dies by adding boolean flag instead of removing from ArrayList.

Future Improvements: Platform clipping feels too fast, possibly perserve aim modifications when turning, tuning bullet bounces across platforms, working on sprites.
