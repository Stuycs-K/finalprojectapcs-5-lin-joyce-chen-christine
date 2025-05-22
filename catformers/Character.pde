import java.util.*;

public class Character {
  String type; 
  int lives, xVelocity, yVelocity, xPos, yPos, bulletCD, maxBulletCD;
  double jumpCharge, aimAngle;
  boolean onGround, bulletFired, ifMoving; 
  PImage sprite;
  
  public Character (String type, int xVelocity, int maxBulletCD, PImage sprite) {
    this.type = type;
    this.xVelocity = xVelocity;
    this.maxBulletCD = maxBulletCD;
    this.sprite = sprite;
  }
  
  void jump() {
  }
  
  void shoot() {
  }
  
  void aim() {
  }
  
  void move() {
  }
}
