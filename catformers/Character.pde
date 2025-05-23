import java.util.*;

public class Character {
  int hitboxWidth, hitboxLength;
  int lives, bulletCD, maxBulletCD; 
  float bulletspeed, walkspeed, jumpCharge, aimAngle;
  float xVelocity, yVelocity, xPos, yPos;
  boolean onGround, bulletFired, ifMoving; 
  PImage sprite;
  
  public Character (float walkspeed, float bulletspeed, int maxBulletCD, /*PImage sprite,*/ float xPos, float yPos) {
    // basic character info
    //this.sprite = sprite;
    this.xPos = xPos;
    this.yPos = yPos;
    hitboxWidth = 20;
    hitboxLength = 40;
    
    // horizontal movement
    this.walkspeed = walkspeed;
    xVelocity = 0.0;
    
    // vertical movement
    yVelocity = g;
    jumpCharge = 1.0;
    
    // projectile info
    this.bulletspeed = bulletspeed;
    this.maxBulletCD = maxBulletCD;
    bulletCD = 0;
    aimAngle = 0.0;
    
    // booleans
    onGround = true;
    bulletFired = false; 
    ifMoving = false;
  }
  
  void jump() {
    // replace the zero later with base jump power!!
    yVelocity = 0 * jumpCharge;
  }
  
  // in keypressed later add a while(jumpcharge < max_jump) so we can set a cap
  void addJumpCharge() {
    jumpCharge += 0.1;
  }
  
  void shoot() {
    projectiles.add(new Projectiles(this, aimAngle, bulletspeed, xPos, yPos));
  }
  
  void aim(boolean goUp) {
    if (goUp) {
      aimAngle += 0.1;
      if (aimAngle == 360.0) {
        aimAngle = 0.0;
      }
    }
    else {
      if (aimAngle == 0.0) {
        aimAngle = 360.0;
      }
      aimAngle -= 0.1;
    }
  }
  
  void move(boolean goRight) {
    if (goRight) {
      xVelocity = walkspeed;
    }
    else {
      xVelocity = -1 * walkspeed;
    }
  }
  
  void freeze() {
    xVelocity = 0.0;
  }
  
  void applyMovement() {
    // in the game itself, keep walking animation until freeze is called (horizontal movement)
    ifMoving = false;
    if (xPos + (hitboxWidth/2) + xVelocity < width && xPos + (hitboxWidth/2) + xVelocity > 0) { //check for borders and anything else that would block horizontal movement
      xPos += xVelocity;
      xVelocity = 0.0;
    }
    
    if (yPos + (hitboxLength/2) + yVelocity < height && yPos - (hitboxLength/2) + yVelocity > 0) { //check for platforms and anything else that would block vertical movement
      yPos += yVelocity;
      ifMoving = true;
    }
  }
  
  void display() {
    rect(xPos, yPos, hitboxWidth, hitboxLength);
  }
  
  void setAnimation() { // sets sprite to either jumping or walking animation --> jumping takes priority over walk
  }
}
