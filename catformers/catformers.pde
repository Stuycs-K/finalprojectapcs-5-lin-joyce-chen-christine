ArrayList<Character> chars;
ArrayList<Projectiles> projectiles;
ArrayList<Platforms> platforms;
String currmode;

static float g = 3.8; // change gravity based on how fast we want them to fall!

void setup() {
  size(1200, 700); // change size of screen if we need to
  currmode = "Menu";
  
  chars = new ArrayList<Character>();
  projectiles = new ArrayList<Projectiles>();
  platforms = new ArrayList<Platforms>();
  
  chars.add(new Character(20.0, 20.0, 60, 200.0, 200.0)); // temp for testing
  chars.add(new Character(20.0, 20.0, 60, 900.0, 200.0));
  
  platforms.add(new Platforms(100, 600, 300, 20)); // I testttt
  platforms.add(new Platforms(500, 400, 100, 20));
  platforms.add(new Platforms(200, 300, 100, 20));
  platforms.add(new Platforms(700, 200, 100, 20));
  platforms.add(new Platforms(300, 500, 300, 20));
  platforms.add(new Platforms(800, 250, 100, 20));
  
}

void draw() {
  background(255);
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
    if (projectiles.get(x).bounceCount < 3) { // change max count if too littlke
      projectiles.get(x).move();
      projectiles.get(x).display();
    }
    else {
      projectiles.remove(x);
      x--;
    }
  }
  
  if (keyPressed) {
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
  // ==== Player 1 ====
  if (!chars.get(0).ifFalling && key == 'w') {
    chars.get(0).jump();
  }
  
  // ==== Player 2 ====
  if (!chars.get(1).ifFalling && keyCode == UP) {
    chars.get(1).jump();
  }
}

void displayScreen() {
  if (currmode.equals("Menu")) {
    
  }
  else if (currmode.equals("Versus")) {
    
  }
  else if (currmode.equals("Boss")) {
    
  }
  else if (currmode.equals("Loss")) {
    
  }
  else if (currmode.equals("Victory")) {
    
  }
}
