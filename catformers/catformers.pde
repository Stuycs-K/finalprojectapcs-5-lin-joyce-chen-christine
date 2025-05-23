ArrayList<Character> chars;
ArrayList<Projectiles> projectiles;
ArrayList<Platforms> platforms;
String currmode;

static float g = 9.81; // change gravity based on how fast we want them to fall!

void setup() {
  size(1200, 700); // change size of screen if we need to
  currmode = "Menu";
  
  chars = new ArrayList<Character>();
  projectiles = new ArrayList<Projectiles>();
  platforms = new ArrayList<Platforms>();
  
  chars.add(new Character(20.0, 20.0, 5, 200.0, 200.0)); // temp for testing
  
  platforms.add(new Platforms(100, 600, 300, 20)); // I testttt
  platforms.add(new Platforms(500, 400, 100, 20));
  platforms.add(new Platforms(200, 300, 100, 20));
  platforms.add(new Platforms(700, 200, 100, 20));
  
}

void draw() {
  background(255);
  for (Character c : chars) {
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
    if (key == 'd') {
      chars.get(0).move(true);
    }
    else if (key == 'a') {
      chars.get(0).move(false);
    }
    if (!chars.get(0).ifFalling && key == 'w') {
      chars.get(0).addJumpCharge();
    }
  }
}

void keyPressed() {
  if (key == 'r') {
    chars.get(0).shoot();
  }
}

void keyReleased() {
  if (!chars.get(0).ifFalling && key == 'w') {
    chars.get(0).jump();
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
