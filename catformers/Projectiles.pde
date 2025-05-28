public class Projectiles {
  // add types when we start making different types of projectiles (i.e. with different types of effects)
  // String type;
  float xVelocity, yVelocity, xPos, yPos;
  int bounceCount, size, exploded;
  String type;
  Character player;
  
  public Projectiles (String type, Character player, float angle, float speed, float xPos, float yPos) {
    this.type = type;
    this.player = player;
    
    this.xPos = xPos;
    this.yPos = yPos;
    xVelocity = speed * cos(angle);
    yVelocity = speed * sin(angle);
    
    exploded = 0;
    
    size = 20;
    bounceCount = 0;
  }
  
  void move() {
    if (type.equals("normal")) {
      if (checkBounce()) {
        bounceCount+=1;
        unclip();
      }
      xPos += xVelocity;
      yPos += yVelocity;
    }
    else if (type.equals("laser")) {
      float tempx = xVelocity;
      float tempy = yVelocity;
      for (Character c : chars) {
        if (c != player) {
          yVelocity += ((c.yPos+c.hitboxLength/2)-yPos)/40.0;
          xVelocity += ((c.xPos+c.hitboxWidth/2)-xPos)/40.0;
        }
      }
      if (checkBounce()) {
        bounceCount+=1;
        unclip();
      }
      xPos += xVelocity;
      yPos += yVelocity;
      xVelocity = tempx;
      yVelocity = tempy;
    }
    else if (type.equals("grenade")) {
      yVelocity += g;
      if (checkBounce()) {
        bounceCount+=1;
        unclip();
      }
      xPos += xVelocity;
      yPos += yVelocity;
    }
  }
  
  void display() {
    if (type.equals("normal")) {
      circle(xPos,yPos,size);
    }
    else if (type.equals("laser")) {
      rect(xPos,yPos,size,size/2);
    }
    else if (type.equals("grenade")) {
      if (bounceCount < 4) {
        circle(xPos,yPos,size);
      }
      else {
        fill(255,0,0);
        rect(xPos,yPos,size*2,size*2);
        fill(255);
        exploded+=1;
      }
    }
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
