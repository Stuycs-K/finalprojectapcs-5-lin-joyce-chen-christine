public class Projectiles {
  // add types when we start making different types of projectiles (i.e. with different types of effects)
  // String type;
  float xVelocity, yVelocity, xPos, yPos;
  int bounceCount;
  Character player
  
  public Projectiles (/*String type,*/ Character player, double angle, float speed, float xPos, float yPos) {
    // this.type = type;
    this.player = player;
    
    this.xPos = xPos;
    this.yPos = yPos;
    xVelocity = speed * cos(angle);
    yVelocity = speed * sin(angle);
    
    bounceCount = 0;
  }
  
  void move() {
    if (checkBounce()) {
      bounceCount++;
    }
    if (bounceCount < 3) { // change max count if too littlke
      xPos += xVelocity;
      yPos += yVelocity;
    }
    else {
      player.projectiles.remove(this);
    }
  }
  
  boolean checkHit() {
  }
  
  boolean checkBounce() {
    boolean bounce = false;
    if () { // check for vertical collisions
      yVelocity *= -1;
      bounce = true;
    }
    if () { // check for horizontal collisions
      xVelocity *= -1;
      bounce = true;
    }
    return bounce;
  }
  
}
