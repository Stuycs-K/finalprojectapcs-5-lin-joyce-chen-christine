public class Boss {
  float xPos, yPos;
  float tpTick; // used to iterate teleportFigure8
  int phase, timer;
  boolean immune;
  ArrayList<Projectiles> bossProjectiles; // make separate BossProjectiles class?

  Boss(float xPos, float yPos) {
    this.xPos = xPos;
    this.yPos = yPos;
    this.phase = 0;
    this.timer = 0;
    this.immune = false;
    bossProjectiles = new ArrayList<Projectiles>();
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
    int startTime = 30;
    int cycleLength = 60;
    if (timer == startTime) {
      trapPlayers();
    }
    int currentCycle = (timer-startTime) / cycleLength;
    if (currentCycle < 4) {
      int cycleTime = (timer - startTime) % cycleLength;
      // blinking red warning beams
      if (cycleTime < 40 && (cycleTime / 10) % 2 == 0) {
        fill(255, 0, 0, 100);
        noStroke();
        if (currentCycle % 2 == 0) {
          rect(0, 0, width, 20);
          rect(0, height - 20, width, 20);
          rect(0, 0, 20, height);
          rect(width - 20, 0, 20, height);
        } else {
          rect(width/2 - 10, 0, 20, height);
          rect(0, height/2 - 10, width, 20);
        }
      }
      if (cycleTime == 40) {
        if (currentCycle % 2 == 0) {
          for (Character c : chars) {
            if (c.yPos < 20 || c.yPos + c.hitboxLength > height - 20 || 
            c.xPos < 20 || c.xPos + c.hitboxWidth > width - 20) {
              c.lives--;
              c.isAlive = c.lives > 0;
            }
          }
        } else {
          for (Character c : chars) {
            if ((c.xPos + c.hitboxWidth > width/2 - 10 && c.xPos < width/2 + 10) ||
            (c.yPos + c.hitboxLength > height/2 - 10 && c.yPos < height/2 + 10)) {
              c.lives--;
              c.isAlive = c.lives > 0;
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
    float a = 200;
    float t = tpTick * 0.05; // controls speed
    xPos = width/2 + (a*cos(t)) / (1+sin(t) * sin(t));
    yPos = height/2 + (a*cos(t) * sin(t)) / (1+sin(t) * sin(t));
  }

}
