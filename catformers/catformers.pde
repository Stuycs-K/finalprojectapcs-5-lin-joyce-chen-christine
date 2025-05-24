ArrayList<Character> chars;
ArrayList<Projectiles> projectiles;
ArrayList<Platforms> platforms;
String currmode;
boolean versusInitialized, selectScreen;
screenSelect s;

static float g = 3.8; // change gravity based on how fast we want them to fall!

void setup() {
  size(1200, 700); // change size of screen if we need to
  currmode = "Menu";

  chars = new ArrayList<Character>();
  projectiles = new ArrayList<Projectiles>();
  platforms = new ArrayList<Platforms>();
  s = new screenSelect();

  versusInitialized = false;
  selectScreen = false;

}

void draw() {
  displayScreen();

  for (Character c : chars) {
    if (c.bulletCD > 0) {
      c.bulletCD--;
    }
    c.applyMovement();
    c.display();

  }

  for (Platforms p : platforms) {
    p.display();
  }

  for (int x = 0; x < projectiles.size(); x++) {
    if (projectiles.get(x).checkHit()) {
      projectiles.remove(x);
    }
    else {
      if (projectiles.get(x).bounceCount < 3) { // change max count if too littlke
        projectiles.get(x).move();
        projectiles.get(x).display();
      }
      else {
        projectiles.remove(x);
        x--;
      }
    }
  }

  for (int x = 0; x < chars.size(); x++) { // just testing to see if characters die
    if (chars.get(x).lives == 0) {
      chars.remove(x);
    }
  }

  if (keyPressed) {
    if (currmode.equals("Menu")) { // for now go to versus, later create a second screen for character selection
      selectScreen = true;
    }
    else if (currmode.equals("Versus")) {
      // ===== Player 1 =====
      if (key == 'd') {
        chars.get(0).move(true);
      } else if (key == 'a') {
        chars.get(0).move(false);
      }
      if (!chars.get(0).ifFalling && key == 'w') {
        chars.get(0).addJumpCharge();
      }

      // ===== Player 2 =====
      if (keyCode == RIGHT) {
        chars.get(1).move(true);
      } else if (keyCode == LEFT) {
        chars.get(1).move(false);
      }
      if (!chars.get(1).ifFalling && keyCode == UP) {
        chars.get(1).addJumpCharge();
      }
    }
  }

}

void keyPressed() {
  // ==== Player 1 ====
  if (key == 'r') {
    chars.get(0).shoot();
  }
  if (key == 'q') {
    chars.get(0).aim(true);
  } else if (key == 'e') {
    chars.get(0).aim(false);
  }

  // ==== Player 2 ====
  if (key == '/') {
    chars.get(1).shoot();
  }
  if (key == ',') {
    chars.get(1).aim(true);
  } else if (key == '.') {
    chars.get(1).aim(false);
  }

}

void keyReleased() {
  if (currmode.equals("Versus")) {
    // ==== Player 1 ====
    if (!chars.get(0).ifFalling && key == 'w') {
      chars.get(0).jump();
    }

    // ==== Player 2 ====
    if (!chars.get(1).ifFalling && keyCode == UP) {
      chars.get(1).jump();
    }
  }
}

void mouseClicked() {
  if (selectScreen) {
    s.buttonClicked();
  }
}

void displayScreen() {
  if (currmode.equals("Menu")) {
    background(0);
    if (!selectScreen) {
      textAlign(CENTER,CENTER);
      textSize(200);
      text("hi",width/2,height/2.5);

      textSize(30);
      text("press any key to start",width/2, height/1.7);
    }
    else {
      s.display();
    }
  }
  else if (currmode.equals("Versus")) {
    background(255);

    if (!versusInitialized) {
      versusInitialized = true;
      chars.add(new Character(20.0, 20.0, 60, 200.0, 200.0)); // temp for testing
      Character p2 = (new Character(20.0, 20.0, 60, 900.0, 200.0));
      p2.facingRight = false;
      p2.aimAngle = 180.0;
      chars.add(p2);
      // add to character class instead?
      
      platforms.add(new Platforms(100, 600, 300)); // I testttt
      platforms.add(new Platforms(500, 400, 100));
      platforms.add(new Platforms(200, 300, 100));
      platforms.add(new Platforms(700, 200, 100));
      platforms.add(new Platforms(300, 500, 300));
      platforms.add(new Platforms(800, 250, 100));
    }
  }
  else if (currmode.equals("Boss")) {

  }
  else if (currmode.equals("Loss")) {

  }
  else if (currmode.equals("Victory")) {

  }
}
