public class Boss {
  float xPos, yPos;
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
      // phase here!
    } else if (phase == 1) {
      // ..
    } else if (phase == 2) {
      // ..
    } else if (phase == 3) {
      // can add more!
    }
    
    for (Projectiles p : bossProjectiles) {
      p.move();
      p.display();
    }
  }
  
  void nextPhase() {
    phase = (phase + 1) % 4; // # of phases!
    timer = 0;
    //imumune = (phase == // immune phase #);
    for (Character c : chars) {
     /* c.inverseControls = false;
      c.isTrapped = false;
      c.spamCount = 0; */
      // add these to char and add more if needed!
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
  
  //add more + complete!
  void giantBeamPhase() {
    if (timer == 100) {
      fill(255, 0, 0, 100);
      rect(0, height - 120, width, 20); // figure out sizing later!
      for (Character c : chars) {
        if (c.yPos + c.hitboxLength > height - 120) {
          c.lives--;
          c.isAlive = c.lives > 0;
        }
      }
    }
  }
  
  void trapPlayer() {
    if (timer == 1) {
      Character trapped = chars.get((int)random(chars.size()));
      trapped.isTrapped = true;
    }
    for (Character c : chars) {
      if (c.isTrapped && c.spamCount > 10) {
        c.isTrapped = false;
        c.spamCount = 0;
      }
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
  
  void teleport() {
  }
  
}
  
      
      
  
