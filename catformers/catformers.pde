ArrayList<Character> chars;
ArrayList<Projectiles> projectiles;
ArrayList<Platforms> platforms;
String currmode;

static float g = 9.81;

void setup() {
  size(1200, 900); // change size of screen if we need to
  currmode = "Menu";
  
  chars = new ArrayList<Character>();
  projectiles = new ArrayList<Projectiles>();
  platforms = new ArrayList<Platforms>();
}

void draw() {
  displayScreen();
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
