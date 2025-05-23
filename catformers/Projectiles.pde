public class Projectiles {
  // add types when we start making different types of projectiles (i.e. with different types of effects)
  // String type;
  float xVelocity, yVelocity, xPos, yPos;
  int bounceCount, size;
  Character player;
  
  public Projectiles (/*String type,*/ Character player, float angle, float speed, float xPos, float yPos) {
    // this.type = type;
    this.player = player;
    
    this.xPos = xPos;
    this.yPos = yPos;
    xVelocity = speed * cos(angle);
    yVelocity = speed * sin(angle);
    
    size = 20;
    bounceCount = 0;
  }
  
  void move() {
    if (checkBounce()) {
      bounceCount+=1;
    }
    xPos += xVelocity;
    yPos += yVelocity;
  }
  
  void display() {
    circle(xPos,yPos,size);
  }
  
  boolean checkHit() {
    return true;
  }
  
  boolean checkBounce() {
    boolean bounce = false;
    if (yPos + yVelocity > height || yPos + yVelocity < 0) { // check for vertical collisions
      yVelocity *= -1;
      bounce = true;
    }
    if (xPos + xVelocity > width || xPos + xVelocity < 0) { // check for horizontal collisions
      xVelocity *= -1;
      bounce = true;
    }
    return bounce;
  }
  
}
