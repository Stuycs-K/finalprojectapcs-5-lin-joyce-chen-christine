public class Projectiles {
  // add types when we start making different types of projectiles (i.e. with different types of effects)
  float xVelocity, yVelocity, xPos, yPos;
  PVector a;
  int bounceCount, size;
  String type;
  Character player;
  boolean shot, exploded;
  
  public Projectiles (String type, Character player, float angle, float speed, float xPos, float yPos) {
    this.type = type;
    this.player = player;
    
    this.xPos = xPos;
    this.yPos = yPos;
    xVelocity = speed * cos(angle);
    yVelocity = speed * sin(angle);
    a = new PVector(0,0);
    
    // unique variables
    exploded = false;
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
      if (bounceCount < 3 && !exploded) {
        circle(xPos,yPos,size);
      }
      else {
        exploded = true;
        fill(255,0,0);
        rect(xPos,yPos,size*2,size*2);
        fill(255);
      }
    }
    else if (type.equals("boss")) {
      fill(255, 100, 100);
      circle(xPos,yPos,size);
    }
  }
  
  boolean checkHit() {
    if (currmode.equals("Versus")) {
      for (Character c : chars) {
        if (!(c == player && bounceCount == 0)) { 
          if (!type.equals("grenade") || !exploded) {
            if(xPos >= c.xPos && xPos <= c.xPos + c.hitboxWidth &&
                yPos >= c.yPos && yPos <= c.yPos + c.hitboxLength) {
              c.lives -= 1;
              hitSound.play();
              if (type.equals("grenade")) {
                exploded = true;
              }
              return true;
            }
          }
          else if (exploded) {
            if(xPos + size*2 > c.xPos && xPos < c.xPos + c.hitboxWidth &&
                yPos + size*2 > c.yPos && yPos < c.yPos + c.hitboxLength) {
              c.lives -= 1;
              hitSound.play();
              return true;
            }
          }
        }
      }
    }
    
    if (currmode.equals("Boss") && !boss.immune && player != null) {
      if (!type.equals("grenade") || !exploded) {
        if (xPos >= boss.xPos - boss.hitboxWidth/2 && xPos <= boss.xPos + boss.hitboxWidth/2 &&
              yPos >= boss.yPos - boss.hitboxLength/2 && yPos <= boss.yPos + boss.hitboxLength/2) {
          boss.lives -= 1;
          if (type.equals("grenade")) {
            exploded = true;
          }
          return true;
        }
      }
      else if (exploded) {
        if(xPos + size*2 >= boss.xPos - boss.hitboxWidth/2 && xPos + size*2 <= boss.xPos + boss.hitboxWidth/2 &&
            yPos + size*2 >= boss.yPos - boss.hitboxLength/2 && yPos + size*2 <= boss.yPos + boss.hitboxLength/2) {
          boss.lives -= 1;
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
        
        if (type.equals("grenade")) {
          if (min(abs((xPos + size/2) - p.xPos), abs((xPos - size/2) - (p.xPos + p.platformWidth))) <
          min(abs((yPos + size/2) - p.yPos), abs((yPos - size/2) - (p.yPos + p.platformHeight)))) {
            xVelocity *= -1;
          } else {
            yVelocity *= -1;
          }
        }
        
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
