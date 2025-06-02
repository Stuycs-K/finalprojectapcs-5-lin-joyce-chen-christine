public class Character {
  int hitboxWidth, hitboxLength, maxLength;
  int lives, maxLives, jumpCharge, bulletCD, maxBulletCD;
  int damageCD, shootTick;
  float maxJumpCharge;
  float bulletspeed, walkspeed, maxWalkSpeed, aimAngle;
  float xVelocity, yVelocity, xPos, yPos;
  float deathX, deathY, deathSlope;
  boolean onGround, bulletFired, ifFalling, isWalking, facingRight, isAlive;
  boolean inverseControls, isTrapped, horizontalJump;
  int spamCount;
  PImage sprite;
  Gif walking;

  public Character (float walkspeed, float bulletspeed, int maxBulletCD, float xPos, float yPos) {
    // basic character info
    this.xPos = xPos;
    this.yPos = yPos;
    hitboxWidth = 55;
    hitboxLength = 70;
    maxLength = hitboxLength;
    lives = 3;
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
    
    // boss effects
    inverseControls = false;
    isTrapped = false;
    spamCount = 0;
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
    hitboxLength = maxLength;
  }

  // in keypressed later add a while(jumpcharge < max_jump) so we can set a cap
  void addJumpCharge() {
    if (jumpCharge < maxJumpCharge) { // change maximum based on base jump power!
      jumpCharge += 4;
      hitboxLength -= 3;
    }
  }
  
  void crouch() {
    hitboxLength = (int)(maxLength/1.5);
    walkspeed = maxWalkSpeed/2;
  }
  
  void unCrouch() {
    float oldLength = hitboxLength;
    hitboxLength = maxLength;
    yPos -= (hitboxLength - oldLength);
    walkspeed = maxWalkSpeed;
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

    if (yPos + hitboxLength > height) {
      yPos = height - hitboxLength;
      yVelocity = 0;
      onGround = true;
      ifFalling = false;
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
  
  void displayJumpBar() {
    fill(50,205,50);
    rect(xPos - 15, yPos - 15, 20, 40.0);
    fill(255);
    rect(xPos - 15, yPos - 15, 20, 40.0*(1-(jumpCharge/maxJumpCharge)));
  }
  
  PImage getPreview() {
    return sprite;
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
