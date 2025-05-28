public class Projectiles {
  // add types when we start making different types of projectiles (i.e. with different types of effects)
  // String type;
  float xVelocity, yVelocity, xPos, yPos;
  PVector a;
  int bounceCount, size, exploded;
  String type;
  Character player;
  boolean shot;
  
  public Projectiles (String type, Character player, float angle, float speed, float xPos, float yPos) {
    this.type = type;
    this.player = player;
    
    this.xPos = xPos;
    this.yPos = yPos;
    xVelocity = speed * cos(angle);
    yVelocity = speed * sin(angle);
    a = new PVector(0,0);
    
    // unique variables
    exploded = 0;
    shot = false;
    
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
      for (Character c : chars) {
        float dist, fmag;
        PVector f;
        if (c != player) {
          PVector otherPos = new PVector(c.xPos+c.hitboxWidth/2, c.yPos+c.hitboxLength/2);
          dist = PVector.sub(new PVector(xPos,yPos), otherPos).mag();
          fmag = 200000 / pow(dist,2);
          f = PVector.sub(otherPos, new PVector(xPos,yPos));
          f.normalize();
          f.setMag(fmag);
          a = a.add(f.div(10));
          xVelocity += a.x;
          yVelocity += a.y;
          a.set(0,0);
        }
      }
      
      if (checkBounce()) {
        bounceCount+=1;
        unclip();
      }
      
      xPos += xVelocity;
      yPos += yVelocity;
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
    else if (type.equals("boss")) {
      xPos += xVelocity;
      yPos += yVelocity;
    }
  }
  
  void display() {
    if (type.equals("normal")) {
      circle(xPos,yPos,size);
    }
    else if (type.equals("laser")) {
      circle(xPos,yPos,size);
    }
    else if (type.equals("grenade")) {
      if (bounceCount < 3) {
        circle(xPos,yPos,size);
      }
      else {
        fill(255,0,0);
        rect(xPos,yPos,size*2,size*2);
        fill(255);
        exploded+=1;
      }
    }
    else if (type.equals("boss")) {
      fill(255, 100, 100);
      circle(xPos,yPos,size);
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
