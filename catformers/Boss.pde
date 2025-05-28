public class Boss {
  float xPos, yPos;
  float tpTick; // used to iterate teleportFigure8
  int hitboxWidth, hitboxLength;
  int phase, timer;
  boolean immune;
  ArrayList<Projectiles> bossProjectiles; // make separate BossProjectiles class?

  Boss(float xPos, float yPos) {
    this.xPos = xPos;
    this.yPos = yPos;
    hitboxWidth = 200;
    hitboxLength = 200;
    phase = 0;
    timer = 0;
    immune = false;
    bossProjectiles = new ArrayList<Projectiles>();
  }
  
  void display() {
    fill(255);
    rect(xPos - hitboxWidth/2, yPos - hitboxLength/2, hitboxWidth, hitboxLength);
  }

  void update() {
    timer++;
    if (timer == 600) { // every minute
      nextPhase();
    }

    if (phase == 0) {
      giantBeamPhase();
    } else if (phase == 1) {
      teleportFigure8(tpTick);
      tpTick++;
      immunePhase();
      inverseControls();
    } else if (phase == 2) {
      teleportFigure8(tpTick);
      tpTick++;
    }

    for (Projectiles p : bossProjectiles) {
      p.move();
      p.display();
    }
  }

  void nextPhase() {
    phase = (phase + 1) % 3; // # of phases!
    timer = 0;
    //imumune = (phase == // immune phase #);
    for (Character c : chars) {
      c.inverseControls = false;
      c.isTrapped = false;
      c.spamCount = 0;
    }
  }

  void immunePhase() {
    if (timer % 10 == 0) {
      int count = 12;
      for (int i = 0; i < count; i++) {
        float angle = radians((360 / count) * i + timer);
        //bossProjectiles.add(new Projectiles(
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
    if (timer == 180) {
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

}
