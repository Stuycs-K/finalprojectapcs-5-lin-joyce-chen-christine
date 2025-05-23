import java.util.*;

public class Character {
  String type; 
  int hitboxWidth, hitboxLength;
  int lives, bulletCD, maxBulletCD; 
  float bulletspeed, walkspeed, jumpCharge;
  float xVelocity, yVelocity, xPos, yPos;
  double aimAngle;
  boolean onGround, bulletFired, ifMoving; 
  PImage sprite;
  ArrayList<Projectiles> projectiles;
  
  public Character (String type, float walkspeed, float bulletspeed, int maxBulletCD, PImage sprite, float xPos, float yPos) {
    // basic character info
    this.type = type;
    this.sprite = sprite;
    this.xPos = xPos;
    this.yPos = yPos;
    
    // horizontal movement
    this.walkspeed = walkspeed;
    xVelocity = 0.0;
    
    // vertical movement
    yVelocity = -1 * g;
    jumpcharge = 1.0;
    
    // projectile info
    projectiles = new ArrayList<Projectiles>();
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
    projectiles.add(new Projectile(this, aimAngle, bulletspeed, xPos, yPos));
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
    if () { //check for borders and anything else that would block horizontal movement
      xPos += xVelocity;
    }
    else { // in the game itself, keep walking animation until freeze is called
      xVelocity = 0.0;
    }
    
    if () { //check for platforms and anything else that would block vertical movement
      yPos += yVelocity;
    }
    else {
      yVelocity = -1 * g;
    }
  }
  
  void setAnimation() { // sets sprite to either jumping or walking animation --> jumping takes priority over walk
  }
}
