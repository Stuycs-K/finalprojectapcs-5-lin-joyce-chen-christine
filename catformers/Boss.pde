public class Boss {
  int lives, maxLives, hitboxWidth, hitboxLength;
  int phase, timer;
  float xPos, yPos;
  float tpTick; // used to iterate teleportFigure8
  boolean immune, homingPhase, warningPhase;
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
    homingPhase = false;
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
    lives = max(0, lives);
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
    if (!gamePause && !gameEnd) {
      timer++;
      if (phase == 0) {
        if (timer == 1200) {
          nextPhase();
        }
      } else if (timer == 600) {
        homingPhase = false;
        nextPhase();
      }
    }

    if (phase == 0) {
      giantBeamPhase();
    } else if (phase == 1  && !gamePause && !gameEnd) {
      if (timer < 200) {
        showWarning();
      } else {
        immunePhase();      
        flowerBeams(300.0, 2, 90); 
        flowerBeams(200.0, 2, 30); 
        inverseControls();
      }
    } else if (phase == 2 && !gamePause && !gameEnd) {
      if (bossProjectiles.size() == 0 || homingPhase) {
        teleportFigure8(tpTick);
        tpTick++;
        generateHoming();
      }
    }

    for (Projectiles p : bossProjectiles) {
      if (!gamePause && !gameEnd) {
        p.move();
      }
      p.display();
      
      if (p.type.equals("boss") && !gamePause) {
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
    
    for (int i = bossProjectiles.size() - 1; i >= 0; i--) {
      Projectiles p = bossProjectiles.get(i);
      if (p.xPos < 0 || p.xPos > width || p.yPos < 0 || p.yPos > height) {
        bossProjectiles.remove(i);
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
      background(bg);
    }
  }

  void immunePhase() {
    immune = true;
    if (timer % 13 == 0) {
      int count = 8;
      for (int i = 0; i < count; i++) {
        float angle = radians((360.0/count) * i + timer);
        bossProjectiles.add(new Projectiles("boss", null, angle, 5, xPos, yPos));
      }
    }
    if (timer % 20 == 0) {
      for (Projectiles p : bossProjectiles) {
        p.xVelocity *= 1.05;
        p.yVelocity *= 1.05;
      }
    }
  }
  
  void showWarning() { 
    if (timer % 20 < 10) {
      float size = 50;
      float r = 150;
      for (int i = 0; i < 10; i++) {
        float angle = TWO_PI/10 * i;
        image(warningSign, xPos + cos(angle)*r - size/2, yPos + sin(angle)*r - size/2, size, size);
      }
    }
  }
    
  
  // based off of polar rose curves
  void flowerBeams(float radius, float k, float petals) {
    pushStyle();
    pushMatrix(); // prevent interference
    translate(xPos, yPos);
    float rotation = sin(timer*0.02) * 0.3;
    rotate(rotation);
    float newK = k + sin(timer*0.02) * 2.5;
    colorMode(HSB, 360, 100, 100, 100); // change colormode to HSB
    noStroke();
    float inc = TWO_PI / petals;
    for (float angle = 0; angle <= TWO_PI; angle += inc) {
      float r = radius * sin(newK * angle);
      float x = r * cos(angle);
      float y = r * sin(angle);
      fill((angle * 180 / PI + timer * 2) % 360, 80, 100, 60); // dynamic colors
      ellipse(x, y, 16, 28); 
      
      float xCor = xPos + cos(rotation)*x - sin(rotation)*y;
      float yCor = yPos + sin(rotation)*x + cos(rotation)*y;
      for (Character c : chars) {
        if (c.damageCD == 0 && c.isAlive) {
          if (xCor >= c.xPos && xCor <= c.xPos + c.hitboxWidth && 
          yCor >= c.yPos && yCor <= c.yPos + c.hitboxLength) {
            c.lives--;
            c.damageCD = 30;
            c.isAlive = c.lives > 0;
          }
        }
      }
    }
    popMatrix();
    popStyle();
  } 

  void giantBeamPhase() {
    pushStyle();
    int startTime = 100;
    int cycleLength = 200;
    if (timer < startTime) return; 
    if (timer == startTime) {
      trapPlayers();
    }
    int currentCycle = (timer-startTime) / cycleLength;
    if (currentCycle < 5) {
      int cycleTime = (timer - startTime) % cycleLength;
      if (cycleTime < 110) {
        if ((cycleTime / 10) % 2 == 0) {
          fill(255, 0, 0, 100);
        } else {
          fill(0, 0, 255, 50);
        }
      } else {
        fill(0, 0, 255, 200);
      }
      noStroke();
      float beamHeight = 80;
      // ==== Mid-Bottom + Mid-Top Beams ====
      if (currentCycle == 0) {
        rect(0, height/2 - 120 - beamHeight/2, width, beamHeight);
        rect(0, height/2 + 120 - beamHeight/2, width, beamHeight); 
      } // ==== Thick Middle Beam ====
      else if (currentCycle == 1) {
        rect(0, height/2 - 40 - beamHeight/2, width, beamHeight);
        rect(0, height/2 + 40 - beamHeight/2, width, beamHeight);
      } // ====  Bottom + Right Beams ====
      else if (currentCycle == 2) {
        rect(0, height - 40 - 80 * 1.5 * 2 - 20, width, beamHeight * 1.2);
        rect(0, height - 40 - 80 * 1.5, width, beamHeight * 1.2);
        rect(width - 90, 0, 50, height);
        rect(width - 190, 0, 50, height);
      } // ==== Top + Left Beams ====
      else if (currentCycle == 3) {
        rect(0, 40, width, beamHeight * 1.2);
        rect(0, 60 + beamHeight * 1.5, width, beamHeight * 1.2);
        rect(40, 0, 50, height);
        rect(140, 0, 50, height);
      } // ==== Evenly-Spaced Beams ====
      else if (currentCycle == 4) {
        for (int i = 0; i < width; i += 85) {
          rect(i, 0, 10, height);
        }
      }
      
      if (cycleTime >= 110) {
        for (Character c : chars) {
          if (c.damageCD == 0) {
            boolean hit = false;
            if (currentCycle == 0) {
              hit = (c.yPos + c.hitboxLength > height/2 - 120 - 40 && c.yPos < height/2 - 120 + 40) ||
              (c.yPos + c.hitboxLength > height/2 + 120 - 40 && c.yPos < height/2 + 120 + 40);
            } else if (currentCycle == 1) {
              hit = (c.yPos + c.hitboxLength > height/2 - 40 - 40 && c.yPos < height/2 - 40 + 40) ||
              (c.yPos + c.hitboxLength > height/2 + 40 - 40 && c.yPos < height/2 + 40 + 40);
            } else if (currentCycle == 2) {
              hit = (c.yPos + c.hitboxLength > height - 40 - 80 * 1.5 * 2 - 20 &&
              c.yPos < height - 40 - 80 * 1.5 - 20) || (c.yPos + c.hitboxLength > height - 40 - 80 * 1.5 && 
              c.yPos < height - 40);
              hit = hit || ((c.xPos + c.hitboxWidth > width -190 && c.xPos < width - 140) ||
              (c.xPos + c.hitboxWidth > width - 90 && c.xPos < width - 40));
            } else if (currentCycle == 3) {
              hit = (c.yPos + c.hitboxLength > 40 && c.yPos < 40 + 80 * 1.2) ||
              (c.yPos + c.hitboxLength > 60 + 80 * 1.5 && c.yPos < 60 + 80 * 1.5 + 80 * 1.2);
              hit = hit || ((c.xPos + c.hitboxWidth > 40 && c.xPos < 90) ||
              (c.xPos + c.hitboxWidth > 140 && c.xPos < 190));
            } else if (currentCycle == 4) {
              hit = false;
              for (int i = 0; i < width; i += 85) {
                if (c.xPos + c.hitboxWidth > i && c.xPos < i + 10) {
                  hit = true;
                }
              }
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
    popStyle();
  }

  void trapPlayers() {
    for (Character c : chars) {
      c.isTrapped = true;
      c.spamCount = 0;
    }
  }

  void inverseControls() {
    if (timer == 250) {
      for (Character c : chars) c.inverseControls = true;
    }
    if (timer == 400) {
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
  
  void generateHoming() { // prelim code -- incomplete feel free to delete or change
    homingPhase = true;
    if (timer % 20 == 0) {
      bossProjectiles.add(new Projectiles("boss", null, 0, 5, xPos, yPos));
    }
    if (timer % 10 == 0) {
      for (Projectiles p : bossProjectiles) {
        float closestX = chars.get(0).xPos;
        float closestY = chars.get(0).yPos;
        float closestDist = sqrt(pow(closestX - p.xPos,2)+pow(closestY - p.yPos,2));
        for (Character c : chars) {
          float dist = sqrt(pow(c.xPos - p.xPos,2)+pow(c.yPos - p.yPos,2));
          if (c.isAlive && dist > closestDist) {
            closestDist = dist;
          }
        }
        p.xVelocity += (closestX - p.xPos)/100.0;
        p.yVelocity += (closestY - p.yPos)/100.0;
      }
    }
  }

}
