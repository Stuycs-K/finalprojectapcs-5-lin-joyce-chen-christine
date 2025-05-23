ArrayList<Character> chars;
//ArrayList<Platforms> platforms;
String currmode;

static float g = 9.81;

void setup() {
  size(1200, 500); // change size of screen if we need to
  currmode = "Menu";
  
  chars = new ArrayList<Character>();
  //platforms = new ArrayList<Platforms>();
  
  chars.add(new Character(20.0, 20.0, 5, 200.0, 200.0)); // temp for testing
}

void draw() {
  background(255);
  for (Character c : chars) {
    c.applyMovement();
    c.display();
    
    c.ifMoving = false;
    
  }
  if (keyPressed) {
    if (key == 'd') {
      chars.get(0).move(true);
      chars.get(0).ifMoving = true;
    }
    else if (key == 'a') {
      chars.get(0).move(false);
      chars.get(0).ifMoving = true;
    }
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
