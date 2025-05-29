public class Boss {
  int lives, maxLives, hitboxWidth, hitboxLength;
  int phase, timer;
  float xPos, yPos;
  float tpTick; // used to iterate teleportFigure8
  boolean immune;
  ArrayList<Projectiles> bossProjectiles; 
  PImage sprite;

  Boss(float xPos, float yPos) {
    this.xPos = xPos;
    this.yPos = yPos;
    maxLives = 10;
    lives = 10;
    hitboxWidth = 200;
    hitboxLength = 145;
    phase = 0;
    timer = 0;
    immune = false;
    bossProjectiles = new ArrayList<Projectiles>();
    sprite = loadImage("bossIdle.png");
  }
  
  void display() {
    pushStyle(); // prevent interference
    
    if (immune && (frameCount % 20 < 10)) {
      stroke(255); 
      strokeWeight(6);
    } else {
      noStroke();
    }
    
    image(sprite, xPos - hitboxWidth/2, yPos - hitboxLength/2, hitboxWidth, hitboxLength);
    
    int hpBarWidth = 150;
    int hpBarHeight = 10;
    float hpPercent = (float) lives / maxLives;
    float hpY;
    if (yPos - hitboxLength/2 - 20 < 0) {
      hpY = yPos + hitboxLength/2 + 10;
    } else {
      hpY = yPos - hitboxLength/2 - 20;
    }
    fill (100);
    rect(xPos - hpBarWidth/2, hpY, hpBarWidth, hpBarHeight);
    fill(50, 205, 50);
    rect(xPos - hpBarWidth/2, hpY, hpBarWidth * hpPercent, hpBarHeight);
    
    popStyle(); 
  }

  void update() {
    timer++;
    if (timer == 600) { // every minute
      nextPhase();
    }

    if (phase == 0) {
      giantBeamPhase();
    } else if (phase == 1) {
      immunePhase();
      inverseControls();
    } else if (phase == 2) {
      teleportFigure8(tpTick);
      tpTick++;
      // generateHoming();
    }

    for (Projectiles p : bossProjectiles) {
      p.move();
      p.display();
      
      if (p.type.equals("boss")) {
        for (Character c : chars) {
          if (c.damageCD == 0 && c.isAlive) {
            if (p.xPos >= c.xPos && p.xPos <= c.xPos + c.hitboxWidth &&
            p.yPos >= c.yPos && p.yPos <= c.yPos + c.hitboxLength) {
              c.lives--;
              c.damageCD = 30;
              c.isAlive = c.lives > 0;
            }
          }
        }
      }
    }
  }

  void nextPhase() {
    phase = (phase + 1) % 3; // # of phases!
    timer = 0;
    immune = false;
    for (Character c : chars) {
      c.inverseControls = false;
      c.isTrapped = false;
      c.spamCount = 0;
    }
  }

  void immunePhase() {
    immune = true;
    if (timer % 5 == 0) {
      int count = 6;
      for (int i = 0; i < count; i++) {
        float angle = radians((360.0/count) * i + timer);
        bossProjectiles.add(new Projectiles("boss", null, angle, 5, xPos, yPos));
      }
    }
    if (timer % 10 == 0) {
      for (Projectiles p : bossProjectiles) {
        p.xVelocity *= 1.15;
        p.yVelocity *= 1.15;
      }
    }
  }

  void giantBeamPhase() {
    int startTime = 100;
    int cycleLength = 200;
    if (timer < startTime) return; 
    if (timer == startTime) {
      trapPlayers();
    }
    int currentCycle = (timer-startTime) / cycleLength;
    if (currentCycle < 4) {
      int cycleTime = (timer - startTime) % cycleLength;
      if (cycleTime < 40 && (cycleTime / 10) % 2 == 0) {
        fill(255, 0, 0, 100);
      } else {
        fill(0, 0, 255, 200);
      }
      noStroke();
      float beamHeight = 80;
      if (currentCycle % 2 == 0) {
        rect(0, height/2 - 120 - beamHeight/2, width, beamHeight);
        rect(0, height/2 + 120 - beamHeight/2, width, beamHeight);
      } else {
        rect(0, height/2 - 40 - beamHeight/2, width, beamHeight);
        rect(0, height/2 + 40 - beamHeight/2, width, beamHeight);
      }
      if (cycleTime >= 40) {
        for (Character c : chars) {
          if (c.damageCD == 0) {
            boolean hit = false;
            if (currentCycle % 2 == 0) {
              hit = (c.yPos + c.hitboxLength > height/2 - 120 - 40 && c.yPos < height/2 - 120 + 40) ||
              (c.yPos + c.hitboxLength > height/2 + 120 - 40 && c.yPos < height/2 + 120 + 40);
            } else {
              hit = (c.yPos + c.hitboxLength > height/2 - 40 - 40 && c.yPos < height/2 - 40 + 40) ||
              (c.yPos + c.hitboxLength > height/2 + 40 - 40 && c.yPos < height/2 + 40 + 40);
            }
            if (hit) {      
              c.lives--;
              c.isAlive = c.lives > 0;
              c.damageCD = 60;
            }
          }
        }
      }
    }
  }

  void trapPlayers() {
    for (Character c : chars) {
      c.isTrapped = true;
      c.spamCount = 0;
    }
  }

  void inverseControls() {
    if (timer == 30) {
      for (Character c : chars) c.inverseControls = true;
    }
    if (timer == 300) {
      for (Character c : chars) c.inverseControls = false;
    }
  }

  // based off of Leminscate of Bernoulli
  void teleportFigure8(float tpTick) {
    float a = 500;
    float t = tpTick * 0.05; // controls speed
    xPos = width/2 + (a*cos(t)) / (1+sin(t) * sin(t));
    yPos = height/2 + (a*cos(t) * sin(t)) / (1+sin(t) * sin(t));
  }
  
  /*void generateHoming() { // prelim code -- incomplete feel free to delete or change
    if (timer % 8 == 0) {
      bossProjectiles.add(new Projectiles("boss", null, 0, 5, xPos, yPos));
    }
    if (timer % 10 == 0) {
      for (Projectiles p : bossProjectiles) {
        float closestX = chars.get(0).xPos;
        float closestY = chars.get(0).yPos;
        float closestDist = sqrt(pow(closestX - p.xPos,2)+pow(closestY - p.yPos,2));
        for (Character c : chars) {
          float dist = sqrt(pow(c.xPos - p.xPos,2)+pow(c.yPos - p.yPos,2));
          if (dist > closestDist) {
            closestDist = dist;
          }
        }
        p.xVelocity += (closestX - p.xPos)/100.0;
        p.yVelocity += (closestY - p.yPos)/100.0;
      }
    }
  }*/

}
