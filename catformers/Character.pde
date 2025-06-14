public class Character {
  int hitboxWidth, hitboxLength, maxWidth, maxLength;
  int lives, maxLives, jumpCharge, bulletCD, maxBulletCD;
  int damageCD, shootTick, iFrameTimer;
  int miniTick, slowTick, bulletTimer;
  float maxJumpCharge;
  float bulletspeed, walkspeed, maxWalkSpeed, aimAngle;
  float xVelocity, yVelocity, xPos, yPos, startX;
  float deathX, deathY, deathSlope;
  boolean onGround, bulletFired, ifFalling, isWalking, facingRight, isAlive, isPlayerTwo;
  boolean inverseControls, isTrapped, horizontalJump, revivable;
  boolean miniMode, miniShrunk, bulletMode, slowMode;
  int spamCount, shootCount;
  String projectileType;
  PImage sprite;
  Gif walking;

  public Character (float walkspeed, float bulletspeed, int maxBulletCD, float xPos, float yPos) {
    // basic character info
    this.xPos = xPos;
    this.yPos = yPos;
    hitboxWidth = 55;
    hitboxLength = 70;
    maxWidth = hitboxWidth;
    maxLength = hitboxLength;
    lives = getInitialLives();
    maxLives = lives;

    // horizontal movement
    this.walkspeed = walkspeed;
    maxWalkSpeed = walkspeed;
    xVelocity = 0.0;

    // vertical movement
    yVelocity = g;
    jumpCharge = 0;
    maxJumpCharge = 32; // change depending on which character

    // projectile info
    this.bulletspeed = bulletspeed;
    this.maxBulletCD = maxBulletCD;
    projectileType = "normal";
    bulletCD = 0;
    aimAngle = 0.0;

    // booleans
    onGround = true;
    bulletFired = false;
    ifFalling = false;
    facingRight = true;
    isAlive = true;
    isWalking = false;
    
    // animation variables
    shootTick = 0;
    miniTick = 0;
    slowTick = 0;
    
    // boss effects
    inverseControls = false;
    isTrapped = false;
    spamCount = 0;
    shootCount = 0;
    damageCD = 0;
  }

  void jump() {
    // replace the number later with base jump power!!
    int power = max(jumpCharge, 15); // base jump
    if (horizontalJump) {
      yVelocity = -power*1.6*(sin(45));
    } else {
      yVelocity = -power * 1.6;
    }
    jumpCharge = 0;
    if (!miniMode) {
      hitboxLength = maxLength;
    } else {
      hitboxLength = (int)(maxLength * 0.5);
    }
  }

  // in keypressed later add a while(jumpcharge < max_jump) so we can set a cap
  void addJumpCharge() {
    if (jumpCharge < maxJumpCharge) { // change maximum based on base jump power!
      jumpCharge += 4;
      hitboxLength -= 3;
    }
  }
  
  void crouch() {
    if (miniMode) {
      hitboxLength = (int)((maxLength*0.5)/1.5);
    } else {
      hitboxLength = (int)(maxLength/1.5);
    }
    walkspeed = walkspeed/2;
  }
  
  void unCrouch() {
    float oldLength = hitboxLength;
    if (!miniMode) {
      hitboxLength = maxLength;
    } else {
      hitboxLength = (int)(maxLength * 0.5);
    }
    yPos -= (hitboxLength - oldLength);
    if (!slowMode) walkspeed = maxWalkSpeed;
    else walkspeed = (int)(maxWalkSpeed * 0.25);
  }

  void shoot() {
    if (bulletCD == 0) {
    float mouthX;
    if (facingRight) {
      mouthX = xPos + hitboxWidth * 0.8;
    } else {
      mouthX = xPos + hitboxWidth * 0.2;
    }
    float mouthY = yPos+ hitboxLength * 0.47;
    
    projectiles.add(new Projectiles("normal", this, radians(aimAngle), bulletspeed, mouthX, mouthY));
    bulletCD = maxBulletCD;
    }
  }

  void aim(boolean goUp) {
    if ((goUp && facingRight) || (!goUp && !facingRight)) {
      aimAngle += 2.0;
      if (aimAngle >= 360.0) {
        aimAngle = 0.0;
      }
    }
    else {
      aimAngle -= 2.0;
      if (aimAngle < 0.0) {
        aimAngle = 360.0;
      }
    }

    if (facingRight) {
      if (aimAngle > 90 && aimAngle < 270) {
        if (aimAngle < 180) {
          aimAngle = 90;
        } else {
          aimAngle = 270;
        }
      }
    } else {
      if (aimAngle < 90 || aimAngle > 270) {
        if (aimAngle > 180) {
          aimAngle = 270;
        } else {
          aimAngle = 90;
        }
      }
    }
  }
  
  void mouseAim(PVector mousePos) {
    float angle = degrees(atan2(mousePos.y - yPos, mousePos.x - xPos));
    if (angle < 0) {
      angle += 360;
    }
    if (facingRight) {
      if (angle > 90 && angle < 270) {
        if (angle < 180) {
          aimAngle = 90;
        } else {
          aimAngle = 270;
        }
      } else {
        aimAngle = angle;
      }
    } else {
      if (angle < 90 || angle > 270) {
        if (angle > 180) {
          aimAngle = 270;
        } else {
          aimAngle = 90;
        }
      } else {
        aimAngle = angle;
      }
    }
  }

  void move(boolean goRight) {
    boolean finalGoRight;
    if (inverseControls) {
      finalGoRight = !goRight;
    } else {
      finalGoRight = goRight;
    }
    
    if (finalGoRight) {
      xVelocity = walkspeed;
      if (!facingRight) {
        facingRight = true;
        if (aimAngle <= 180) {
          aimAngle = 180 - aimAngle;
        }
        else {
          aimAngle = 360 - (aimAngle - 180);
        }
      }
    } else {
      xVelocity = -1 * walkspeed;
      if (facingRight) {
        facingRight = false;
        if (aimAngle <= 90) {
          aimAngle = 180 - aimAngle;
        }
        else {
          aimAngle = 180 + (360 - aimAngle);
        }
      }
    }
  }

  void applyMovement() {  
    ifFalling = false;
    if (xPos - 6.0 + hitboxWidth + xVelocity < width && xPos + 2.0 + xVelocity > 0) { //check for borders and anything else that would block horizontal movement
      xPos += xVelocity;
      xVelocity = 0.0;
    }
    
    yVelocity += g;
    onGround = false; // check for platform collisions
    float xMargin = 2.0; // margin to ignore for bigger hitbox
    
    float maxChange = 1.0;
    float remaining = yVelocity;
    float direction; // moving up or down
    if (yVelocity > 0) {
      direction = 1;
    } else {
      direction = -1;
    }
    while (abs(remaining) > 0.0 && !onGround) {
      float move;
      if (abs(remaining) < maxChange) {
        move = abs(remaining);
      } else {
        move = maxChange;
      }
      move *= direction;
      yPos += move;
      remaining -= move;
      
      for (int i = 0; i < platforms.size(); i++) {
        Platforms p = platforms.get(i);
        if (yVelocity >= 0 && yPos + hitboxLength >= p.yPos && yPos + hitboxLength <= p.yPos + abs(move) &&
        xPos + hitboxWidth - xMargin > p.xPos && xPos + xMargin < p.xPos + p.platformWidth) {
            yPos = p.yPos - hitboxLength;
            yVelocity = 0;
            onGround = true;
            ifFalling = false;
            
            i = platforms.size(); // can we use breakkk!
        }
      }
      
      if (horizontalJump && !onGround) {
        if (facingRight && xPos - 6.0 + hitboxWidth + abs(move)/2 < width) {
          xPos += abs(move)/2;
        } else if (xPos + abs(move)/2 + 2.0 > 0) {
          xPos -= abs(move)/2;
        }
      }
    }
    if (!onGround) {
      ifFalling = true;
      if (jumpCharge > 0) {
        jumpCharge = 0;
        hitboxLength = maxLength;
      }
      yVelocity += g;
    }

    if (yPos < 0) {
      yPos = 1;
      yVelocity = 0;
      onGround = false;
    }
    
    if (damageCD > 0) {
      damageCD--;
    }
        
  }
  
  void reset(boolean resetLives) {
    xPos = startX;
    yPos = height - 150;  
    xVelocity = 0.0;
    yVelocity = g;
    jumpCharge = 0;
    hitboxLength = maxLength;
    
    onGround = true;
    bulletFired = false;
    ifFalling = false;
    isWalking = false;
    isAlive = true;
    
    bulletCD = 0;
    shootTick = 0;
    facingRight = true;
    aimAngle = 0.0;
    
    if (isPlayerTwo && !storyMode) {
      facingRight = false;
      aimAngle = 180.0;
    } else {
      facingRight = true;
      aimAngle = 0.0;
    }
    
    if (resetLives) {
      lives = maxLives;
    } else {
      lives--;
      iFrameTimer = 100;
    }

    inverseControls = false;
    isTrapped = false;
    spamCount = 0;
    shootCount = 0;
    damageCD = 0;
    
    walkspeed = maxWalkSpeed;
    horizontalJump = false;
    
    // potion booleans
    miniShrunk = false;
    miniMode = false;
    bulletMode = false;
  }
  
  void updateMiniMode() {
    if (miniMode) {
      miniTick++;
      if (miniTick == 1) {
        hitboxWidth = (int)(maxWidth * 0.5);
        hitboxLength = (int)(maxLength * 0.5);
        miniShrunk = true;
      }
      if (miniTick > 400) {
        miniMode = false;  
      }
    }
    if (!miniMode && miniShrunk) {
      miniTick = 0;
      yPos -= (maxLength * 0.5);
      hitboxWidth = maxWidth;
      hitboxLength = maxLength;
      miniShrunk = false;
    }
  }
  
  void applySlowMode() {
    if (slowMode && slowTick <= 400) {
      walkspeed = (int)(maxWalkSpeed * 0.25);
      slowTick++;
    } else {
      slowMode = false;
      walkspeed = maxWalkSpeed;
      slowTick = 0;
    }
  }
  
  void applyBulletMode() {
    float mouthX;
    if (facingRight) {
      mouthX = xPos + hitboxWidth * 0.8;
    } else {
      mouthX = xPos + hitboxWidth * 0.2;
    }
    float mouthY = yPos+ hitboxLength * 0.47;
    if (bulletMode && bulletTimer <= 400) {
      if (shootCount > 0) {
        if (shootCount <= 20) {
          if (shootCount % 10 == 0) {
            projectiles.add(new Projectiles(projectileType, this, radians(aimAngle), bulletspeed, mouthX, mouthY));
            shootSound.play();
            shootTick++;
          }
          shootCount++;
        } else shootCount = 0;
      }
      bulletTimer++;
    } else {
      bulletMode = false;
      bulletTimer = 0;
      shootCount = 0;
    }
  }

  void displayJumpBar() {
    fill(50,205,50);
    rect(xPos - 15, yPos - 15, 20, 40.0);
    fill(255);
    rect(xPos - 15, yPos - 15, 20, 40.0*(1-(jumpCharge/maxJumpCharge)));
  }
  
  PImage getPreview() {
    return sprite;
  }
  
  int getInitialLives() {
    if (demoMode && numPlayer.equals("1")) return 33;
    if (demoMode && numPlayer.equals("2")) return 15;
    return 3;
  }

  void display() {
    // line to check aim angles
    float angle = radians(aimAngle);
    float len = 40;
    float mouthX;
    if (facingRight) {
      mouthX = xPos + hitboxWidth * 0.8;
    } else {
      mouthX = xPos + hitboxWidth * 0.2;
    }
    float mouthY = yPos + hitboxLength * 0.35;
    line(mouthX, mouthY, mouthX + cos(angle) * len, mouthY + sin(angle) * len);
    
    rect(xPos, yPos, hitboxWidth, hitboxLength);
    
    if (jumpCharge > 0) {
      displayJumpBar();
    }
  }

}
