/*public class Boss {
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
      c.inverseControls = false;
      c.isTrapped = false;
      c.spamCount = 0;
      // add these to char and add more if needed!
    }
  }
  
  //add more + complete!
  void giantBeamPhase() {
  }*/
  
      
      
  
