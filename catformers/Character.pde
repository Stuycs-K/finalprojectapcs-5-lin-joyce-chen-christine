import java.util.*;

public class Character {
  int hitboxWidth, hitboxLength;
  int lives, jumpCharge, maxJumpCharge, bulletCD, maxBulletCD;
  float bulletspeed, walkspeed, aimAngle;
  float xVelocity, yVelocity, xPos, yPos;
  boolean onGround, bulletFired, ifFalling, facingRight, isAlive;
  PImage sprite;

  public Character (float walkspeed, float bulletspeed, int maxBulletCD, float xPos, float yPos) {
    // basic character info
    this.xPos = xPos;
    this.yPos = yPos;
    hitboxWidth = 60;
    hitboxLength = 84;
    lives = 3;

    // horizontal movement
    this.walkspeed = walkspeed;
    xVelocity = 0.0;

    // vertical movement
    yVelocity = g;
    jumpCharge = 0;

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
  }

  void jump() {
    // replace the number later with base jump power!!
    int power = max(jumpCharge, 15); // base jump
    yVelocity = -power * 3;
    jumpCharge = 0;
  }

  // in keypressed later add a while(jumpcharge < max_jump) so we can set a cap
  void addJumpCharge() {
    if (jumpCharge < 60) { // change maximum based on base jump power!
      jumpCharge += 3;
    }
  }

  void shoot() {
    if (bulletCD == 0) {
      projectiles.add(new Projectiles(this, radians(aimAngle), bulletspeed, xPos, yPos));
      bulletCD = maxBulletCD;
    }
  }

  void aim(boolean goUp) {
    if (goUp) {
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

  // change to preserve aimm angle modifications or keep resetting?
  void move(boolean goRight) {
    if (goRight) {
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

  void freeze() {
    xVelocity = 0.0;
  }

  void applyMovement() {
    // in the game itself, keep walking animation until freeze is called (horizontal movement)
    ifFalling = false;
    if (xPos + hitboxWidth + xVelocity < width && xPos + hitboxWidth + xVelocity > 0) { //check for borders and anything else that would block horizontal movement
      xPos += xVelocity;
      xVelocity = 0.0;
    }

    yVelocity += g;
    onGround = false; // check for platform collisions
    float margin = 5.0; // margin of tolerance
    for (Platforms p : platforms) {
      if (yVelocity >= 0 && yPos + hitboxLength <= p.yPos && yPos + hitboxLength + yVelocity >= p.yPos &&
      xPos + hitboxWidth - margin > p.xPos && xPos - hitboxWidth + margin < p.xPos + p.platformWidth) {
          yPos = p.yPos - hitboxLength;
          yVelocity = 0;
          onGround = true;
          ifFalling = false;
      }
    }
    if (!onGround && yPos + hitboxLength + yVelocity < height && yPos - hitboxLength + yVelocity > 0) {
      yPos += yVelocity;
      ifFalling = true;
      if (jumpCharge > 0) {
        jumpCharge--;
      } else {
        jumpCharge = 0;
        yVelocity = g;
      }
    }

    if (yPos + hitboxLength > height) {
      yPos = height - hitboxLength;
      yVelocity = 0;
      onGround = true;
      ifFalling = false;
    }

    if (yPos - hitboxLength < 0) {
      yPos = hitboxLength;
      yVelocity = 0;
    }
  }

  void display() {
    // line to check aim angles
    float angle = radians(aimAngle);
    float len = 40;
    line(xPos, yPos, xPos + cos(angle) * len, yPos + sin(angle) * len);
    
    rect(xPos, yPos, hitboxWidth, hitboxLength);
  }

  void setAnimation() { // sets sprite to either jumping or walking animation --> jumping takes priority over walk
  }
}
