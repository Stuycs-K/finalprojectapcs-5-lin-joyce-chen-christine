import gifAnimation.*;

ArrayList<Character> chars;
ArrayList<Projectiles> projectiles;
ArrayList<Platforms> platforms;
String currmode, numPlayer;
boolean modeInitialized, selectScreen, gameEnd;
screenSelect s;

// things for graphics
Gif start;
PImage title;
PImage bg;

// walk animations
Gif cat1walkR;
Gif cat1walkL;

static float g = 3.5; // change gravity based on how fast we want them to fall!

final int MAX_KEY = 128;
final int MAX_KEYCODE = 256;
boolean[] p1Keys = new boolean[MAX_KEY];
boolean[] p2Keys = new boolean[MAX_KEYCODE];

void setup() {
  size(1280, 720); // change size of screen if we need to
  currmode = "Menu";
  numPlayer = "0";

  chars = new ArrayList<Character>();
  projectiles = new ArrayList<Projectiles>();
  platforms = new ArrayList<Platforms>();
  s = new screenSelect();
  
  // graphicsss
  start = new Gif(this, "start.gif");
  start.play();
  title = loadImage("title.png");
  bg = loadImage("background1.png");
  
  // walking animation
  cat1walkR = new Gif(this,"cat1walkR.gif");
  cat1walkL = new Gif(this,"cat1walkL.gif");
  cat1walkR.play();
  cat1walkL.play();
  
  modeInitialized = false;
  selectScreen = false;
  gameEnd = false; 

}

void draw() {
  displayScreen();
  
  boolean gameOver = currmode.equals("Victory") || currmode.equals("Loss");
  for (Character c : chars) {
    if (c.isAlive) {
      if (!gameOver && c.bulletCD > 0) {
        c.bulletCD--;
      }
      if (!gameOver) {
        c.applyMovement();
      }
    }
      c.display();
  }

  if (!gameOver) {
    for (Platforms p : platforms) {
      p.display();
    }
  }

  for (int x = 0; x < projectiles.size(); x++) {
    if (!gameOver && projectiles.get(x).checkHit()) {
      projectiles.remove(x);
      x--;
    }
    else {
      if (!gameOver) {
        if (projectiles.get(x).exploded < 2 && 
              (projectiles.get(x).bounceCount < 3 || projectiles.get(x).type.equals("grenade"))) { // change max count if too littlke
          projectiles.get(x).move();
        } else {
          projectiles.remove(x);
          x--;
        }
      }
      if (x >= 0 && x < projectiles.size()) {
        projectiles.get(x).display();
      }
    }
  }

  for (Character c : chars) {
    if (c.lives <= 0 && c.isAlive) {
      c.isAlive = false;
      c.deathSlope = random(-5,5) * 10.0;
      while (c.deathSlope == 0.0) {
        c.deathSlope = random(-5,5) * 10.0;
      }
      gameEnd = true;
    }
  }

  if (keyPressed) {
    if (currmode.equals("Menu")) { // for now go to versus, later create a second screen for character selection
      selectScreen = true;
    }
    else if (currmode.equals("Versus") || currmode.equals("Boss")) {
      // ===== Player 1 =====
      if (p1Keys['a']) {
        chars.get(0).move(false);
        chars.get(0).isWalking = true;
      } else if (p1Keys['d']) {
        chars.get(0).move(true);
        chars.get(0).isWalking = true;
      }
      if (p1Keys['w'] && !chars.get(0).ifFalling) {
        chars.get(0).addJumpCharge();
      }
      if (p1Keys['q']) {
        chars.get(0).aim(true);
      } else if (p1Keys['e']) {
        chars.get(0).aim(false);
      }
      if (p1Keys['r']) {
        chars.get(0).shoot();
      }

      // ===== Player 2 =====
      if (numPlayer.equals("2")) {
        if (p2Keys[LEFT]) {
          chars.get(1).move(false);
          chars.get(1).isWalking = true;
        } else if (p2Keys[RIGHT]) {
          chars.get(1).move(true);
          chars.get(1).isWalking = true;
        }
        if (p2Keys[UP] && !chars.get(1).ifFalling) {
          chars.get(1).addJumpCharge();
        }
        if (p2Keys[',']) {
          chars.get(1).aim(true);
        } else if (p2Keys['/']) {
          chars.get(1).aim(false);
        }
        if (p2Keys['.']) {
          chars.get(1).shoot();
        }
      }
    }
  }

}

void keyPressed() {
  if (key < MAX_KEY) p1Keys[key] = true;
  if (keyCode < MAX_KEYCODE) p2Keys[keyCode] = true;
  
  if (currmode.equals("Victory") || currmode.equals("Loss")) {
    if (keyCode == ENTER || keyCode == RETURN) {
      setup();
    }
  }

}

void keyReleased() {
  if (key < MAX_KEY) p1Keys[key] = false;
  if (keyCode < MAX_KEYCODE) p2Keys[keyCode] = false;
  
  if (currmode.equals("Versus") || currmode.equals("Boss")) {
    // ==== Player 1 ====
    if (!chars.get(0).ifFalling && key == 'w') {
      chars.get(0).jump();
    }
    // turn walking animation off
    if (key == 'd' || key == 'a') {
      chars.get(0).isWalking = false;
    } 

    // ==== Player 2 ====
    if (numPlayer.equals("2")) {
      if (!chars.get(1).ifFalling && keyCode == UP) {
        chars.get(1).jump();
      }
      // turn walking animation off
      if (keyCode == RIGHT || keyCode == LEFT) {
        chars.get(1).isWalking = false;
      } 
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
    if (!selectScreen) {
      background(start);
      image(title,width/4.3,height/4);

      textAlign(CENTER,CENTER);
      textSize(200);
      fill(0);
      textSize(30);
      text("< press any key to start >",width/2, height/1.8);
      fill(255);
    }
    else {
      s.display();
    }
  }
  else if (currmode.equals("Versus")) {
    image(bg, 0, 0, width, height);
    image(loadImage("p1.png"), 20, 30, 60, 44.4);
    image(loadImage("p2.png"), 20, 80, 60, 44.4);
    if (!modeInitialized) {
      modeInitialized = true;
      chars.add(new catFirst(20.0, 20.0, 60, 100.0, height - 125)); // temp for testing
      Character p2 = (new catFirst(20.0, 20.0, 60, 1150.0, height - 125));
      p2.facingRight = false;
      p2.aimAngle = 180.0;
      chars.add(p2);
      // add to character class instead?
      
      platforms.add(new Platforms(0, height - 20, width)); // floor
      platforms.add(new Platforms(0, height - 125, 200)); 
      platforms.add(new Platforms(350, height - 125, 200));
      platforms.add(new Platforms(700, height - 125, 200));
      platforms.add(new Platforms(1050, height - 125, width-1050));
      
      platforms.add(new Platforms(250, height - 250, 50));
      platforms.add(new Platforms(600, height - 250, 50));
      platforms.add(new Platforms(950, height - 250, 50));
      
      platforms.add(new Platforms(0, height - 375, 200)); 
      platforms.add(new Platforms(350, height - 375, 200));
      platforms.add(new Platforms(700, height - 375, 200));
      platforms.add(new Platforms(1050, height - 375, width-1050));
      
      platforms.add(new Platforms(250, height - 525, 750));
    }
    
    if (gameEnd) {
      currmode = "Victory";
    }
  }
  else if (currmode.equals("Boss")) {
    background(255);

    if (!modeInitialized) {
      modeInitialized = true;
      chars.add(new catFirst(20.0, 20.0, 60, 200.0, 200.0)); // temp for testing
      if (numPlayer.equals("2")) {
        Character p2 = (new catFirst(20.0, 20.0, 60, 900.0, 200.0));
        p2.facingRight = false;
        p2.aimAngle = 180.0;
        chars.add(p2);
      }
      // add to character class instead?
      
      platforms.add(new Platforms(0, height - 20, width)); // floor!
      platforms.add(new Platforms(100, 600, 300)); // I testttt
      platforms.add(new Platforms(500, 400, 100));
      platforms.add(new Platforms(200, 300, 100));
      platforms.add(new Platforms(700, 200, 100));
      platforms.add(new Platforms(300, 500, 300));
      platforms.add(new Platforms(800, 250, 100));
    }
  }
  else if (currmode.equals("Loss")) {

  }
  else if (currmode.equals("Victory")) {
    image(bg, 0, 0, width, height);
    image(loadImage("p1.png"), 20, 30, 60, 44.4);
    image(loadImage("p2.png"), 20, 80, 60, 44.4);
    for (Platforms p : platforms) {
      p.display();
    }
    String winText = "Player ";
    fill(0);
    rect(width/3.25, height/3.25, 500, 300);
    for (Character c : chars) {
      if (c.isAlive) {
        winText += chars.indexOf(c) + 1;
      }
      else {
        deathAnimation(c);
      }
    }
    fill(255);
    textSize(70);
    text(winText,width/2, height/2.20);
    text("wins!",width/2, height/1.80);
    
    textSize(20);
    text("press [enter] to return to start screen",width/2, height/1.50);
  }
}

void deathAnimation(Character c) {
  c.xPos += 40;
  c.yPos += c.deathSlope;
}
