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
      unclip();
    }
    xPos += xVelocity;
    yPos += yVelocity;
  }
  
  void display() {
    circle(xPos,yPos,size);
  }
  
  boolean checkHit() {
    for (Character c : chars) {
      if (!(c == player && bounceCount == 0)) { 
        if(xPos >= c.xPos && xPos <= c.xPos + c.hitboxWidth &&
        yPos >= c.yPos && yPos <= c.yPos + c.hitboxLength) {
          c.lives -= 1;
          return true;
        }
      }
    }
    return false;
  }
  
  boolean checkBounce() {
    boolean bounce = false;
      // ==== Wall collisions ==== 
    if (yPos + yVelocity > height || yPos + yVelocity < 0) { // check for vertical collisions
      yVelocity *= -1;
      bounce = true;
    }
    if (xPos + xVelocity > width || xPos + xVelocity < 0) { // check for horizontal collisions
      xVelocity *= -1;
      bounce = true;
    }
    
    // ==== Platform collisions ====
    for (Platforms p : platforms) {
      if (xPos + size/2 > p.xPos && xPos - size/2 < p.xPos + p.platformWidth && 
      yPos + size/2 > p.yPos && yPos - size/2 < p.yPos + p.platformHeight) {
        if (yPos < p.yPos || yPos > p.yPos + p.platformHeight) {
          yVelocity *= -1;
        } else {
          xVelocity *= -1;
        }
        bounce = true;
      }
    }
    
    return bounce;
  }
  
  void unclip() {
    for (Platforms p : platforms) {
      if (xPos + xVelocity > p.xPos && xPos + xVelocity < p.xPos + p.platformWidth && 
              yPos + yVelocity > p.yPos && yPos + yVelocity < p.yPos + p.platformHeight) {
        if (yPos < p.yPos || yPos > p.yPos + p.platformHeight) {
          yVelocity *= -1;
        } else {
          xVelocity *= -1;
        }
      }
    }
  }
  
}
