import gifAnimation.*;

ArrayList<Character> chars;
ArrayList<Projectiles> projectiles;
ArrayList<Platforms> platforms;
Boss boss;
String currmode, numPlayer;
boolean modeInitialized, selectScreen, gameEnd, gamePause, deathFinish;
screenSelect s;

// things for graphics
Gif start;
Gif death;
PImage title;
PImage bg;
PImage[] deathFrames;
int deathFrame;
PImage warningSign;
PImage blankSign;

// walk animations
Gif cat1walkR;
Gif cat1walkL;
Gif cat1walkOpenR;
Gif cat1walkOpenL;

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
  
  deathFrames = Gif.getPImages(this, "explosion.gif");
  deathFrame = 0;
  deathFinish = false;
  
  warningSign = loadImage("warningSign.png");
  blankSign = loadImage("blankSign.png");
  
  // walking animation
  cat1walkR = new Gif(this,"cat1walkR.gif");
  cat1walkL = new Gif(this,"cat1walkL.gif");
  cat1walkR.play();
  cat1walkL.play();
  
  // shooting frame
  cat1walkOpenR = new Gif(this, "cat1walkOpenR.gif");
  cat1walkOpenL = new Gif(this, "cat1walkOpenL.gif");
  cat1walkOpenR.play();
  cat1walkOpenL.play();
  
  modeInitialized = false;
  selectScreen = false;
  gameEnd = false; 
  gamePause = false;

}

void draw() {
  displayScreen();
  
  boolean gameOver = currmode.equals("Victory") || currmode.equals("Loss");
  for (Character c : chars) {
    if (c.isAlive && !gamePause) {
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
      if (projectiles.get(x).type.equals("grenade")) {
        if (projectiles.get(x).exploded) {
          projectiles.get(x).display();
          projectiles.remove(x);
          x--;
        }
      }
      else {
        projectiles.remove(x);
        x--;
      }
    }
    else {
      if (!gameOver && !gamePause) {
        if (projectiles.get(x).bounceCount < 3) { // change max count if too littlke
          projectiles.get(x).move();
        } else {
          if (projectiles.get(x).exploded) {
            projectiles.get(x).checkHit();
          }
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
      c.deathX = c.xPos;
      c.deathY = c.yPos;
      gameEnd = true;
    }
    
    if(c.isTrapped) {
      pushStyle();
      float bW = 180;
      float bH = 38;
      fill(0, 0, 0, 120);
      noStroke();
      rect(c.xPos + c.hitboxWidth/2 - bW/2, c.yPos - 50, bW, bH, 8);
      textAlign(CENTER, CENTER);
      textSize(16);
      fill(255);
      text("TRAPPED!", c.xPos + c.hitboxWidth/2, c.yPos - 40);
      text("Spam to Escape!", c.xPos + c.hitboxWidth/2, c.yPos - 26);

      // trap cage bars
      stroke(0);
      strokeWeight(2);
      float x = c.xPos - 4, y = c.yPos - 4, w = c.hitboxWidth + 8, h = c.hitboxLength + 8;
      for (int i = 1; i <= 5; i++) {
        float barX = x + (w/4) * (i - .5) - 7;
        line(barX, y, barX, y + h);
      }
      line(x, y, x + w, y);
      line(x, y + h, x + w, y + h);
      // warning sign
      float size = 40;
      image(warningSign, c.xPos + c.hitboxWidth/2 - size/2, c.yPos - 100, size, size);
      
      popStyle();
    }
    
    if (c.inverseControls) {
      pushStyle();
      float bW = 160;
      float bH = 30;
      fill(0, 0, 0, 120);
      noStroke();
      rect(c.xPos + c.hitboxWidth/2 - bW/2, c.yPos - 35, bW, bH, 8);
      textAlign(CENTER, CENTER);
      textSize(16);
      fill(255);
      text("Inverse Controls!", c.xPos + c.hitboxWidth/2, c.yPos - 20);
      float size = 40;
      image(warningSign, c.xPos + c.hitboxWidth/2 - size/2, c.yPos - 80, size, size);
      popStyle();
    }
    
  }
  
  if (currmode.equals("Boss")) {
    boss.update();
    boss.display();
  }    
  
  if (gamePause) {
    fill(0);
    stroke(255);
    strokeWeight(5);
    rect(width/3.25, height/3.25, 500, 300);
    strokeWeight(1);
    stroke(0);
    fill(255);
    textSize(70);
    text("MENU",width/2, height/2.20);
    textSize(40);
    if (mouseX >= width/2 - 32 && mouseX <= width/2 + 32 &&
          mouseY >= height/1.80 - 20 && mouseY <= height/1.80 + 20) {
      text("> exit <",width/2, height/1.80);
    } else {
      text("exit",width/2, height/1.80);
    }
    if (mouseX >= width/2 - 55 && mouseX <= width/2 + 55 &&
          mouseY >= height/1.60 - 20 && mouseY <= height/1.60 + 20) {
      text("> restart <",width/2, height/1.60);
    } else {
      text("restart",width/2, height/1.60);
    }
  }

  if (keyPressed) {
    if (currmode.equals("Menu")) { // for now go to versus, later create a second screen for character selection
      selectScreen = true;
    }
    else if (currmode.equals("Versus") || currmode.equals("Boss")) {
      if (!gamePause) {
        if (!chars.get(0).isTrapped && chars.get(0).isAlive) {
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
          else if (p1Keys['s']) {
            chars.get(0).crouch();
          }
          if (p1Keys['q']) {
            chars.get(0).aim(true);
          } else if (p1Keys['e']) {
            chars.get(0).aim(false);
          }
          if (p1Keys['r']) {
            chars.get(0).shoot();
          }
        }
  
        // ===== Player 2 =====
        if (numPlayer.equals("2") && !chars.get(1).isTrapped && chars.get(1).isAlive) {
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
          else if (p2Keys[DOWN]) {
            chars.get(1).crouch();
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

}

void keyPressed() {
  if (key < MAX_KEY) p1Keys[key] = true;
  if (keyCode < MAX_KEYCODE) p2Keys[keyCode] = true;
  
  if (!gameEnd) {
    for (Character c : chars) {
      if (c.isTrapped) {
        if (c.jumpCharge > 0 || c.hitboxLength < c.maxLength) {
          c.jumpCharge = 0;
          c.unCrouch();
        }
        c.spamCount++;
        if (c.spamCount >= 10) {
          c.isTrapped = false;
          c.spamCount = 0;
        }
      }
    }
  }
  
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
      if (key == ' ') {
        gamePause = !gamePause;
      }
     if (!gamePause) {
      // ==== Player 1 ====
      if (!chars.get(0).isTrapped && !chars.get(0).ifFalling && chars.get(0).isAlive && key == 'w') {
        chars.get(0).jump();
      }
      // turn walking animation off
      if (key == 'd' || key == 'a') {
        chars.get(0).isWalking = false;
      } 
      
      if (key == 's') {
        chars.get(0).unCrouch();
      }
  
      // ==== Player 2 ====
      if (numPlayer.equals("2")) {
        if (!chars.get(1).isTrapped && !chars.get(1).ifFalling && chars.get(1).isAlive && keyCode == UP) {
          chars.get(1).jump();
        }
        // turn walking animation off
        if (keyCode == RIGHT || keyCode == LEFT) {
          chars.get(1).isWalking = false;
        } 
        
        if (keyCode == DOWN) {
          chars.get(1).unCrouch();
        } 
      }
    }
    
  }
}

void mouseClicked() {
  if (selectScreen) {
    s.buttonClicked();
  }
  if (gamePause) {
    if (mouseX >= width/2 - 32 && mouseX <= width/2 + 32 &&
          mouseY >= height/1.80 - 20 && mouseY <= height/1.80 + 20) {
      setup();
    }
    if (mouseX >= width/2 - 55 && mouseX <= width/2 + 55 &&
          mouseY >= height/1.60 - 20 && mouseY <= height/1.60 + 20) {
      while (chars.size() > 0) {
        chars.remove(0);
      }
      while (projectiles.size() > 0) {
        projectiles.remove(0);
      }
      while (platforms.size() > 0) {
        platforms.remove(0);
      }
      modeInitialized = false;
      gamePause = false;
    }
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
    image(loadImage("p2.png"), width-90, 30, 60, 44.4);
    if (!modeInitialized) {
      modeInitialized = true;
      chars.add(new catFirst(20.0, 20.0, 60, 100.0, height - 125)); // temp for testing
      Character p2 = (new catFirst(20.0, 20.0, 60, 1150.0, height - 125));
      p2.facingRight = false;
      p2.aimAngle = 180.0;
      chars.add(p2);
      
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
    image(bg, 0, 0, width, height);

    if (!modeInitialized) {
      modeInitialized = true;
      boss = new Boss(640, height - 522);
      chars.add(new catFirst(15.0, 15.0, 60, 200.0, height - 100)); // temp for testing
      if (numPlayer.equals("2")) {
        Character p2 = (new catFirst(15.0, 15.0, 60, 900.0, height - 100));
        p2.facingRight = false;
        p2.aimAngle = 180.0;
        chars.add(p2);
      }
      
      platforms.add(new Platforms(0, height - 20, width)); // floor
      
      platforms.add(new Platforms(0, height - 175, 284)); 
      platforms.add(new Platforms(0, height - 450, 284));
      
      platforms.add(new Platforms(498, height - 175, 284)); 
      platforms.add(new Platforms(498, height - 450, 284)); 
      
      platforms.add(new Platforms(996, height - 175, 284)); 
      platforms.add(new Platforms(996, height - 450, 284));
      
      platforms.add(new Platforms(304, height - 312, 174)); 
      platforms.add(new Platforms(802, height - 312, 174)); 
    }
    
    int deathCount = 0;
    for (Character c : chars) {
      if (!c.isAlive) {
        deathCount+=1; 
      }
    }
    if (deathCount > 1) {
      currmode = "Loss";
    } else {
      deathCount = 0;
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
    stroke(255);
    strokeWeight(5);
    rect(width/3.25, height/3.25, 500, 300);
    strokeWeight(1);
    stroke(0);
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
  if (deathFrame == 17) {
    deathFrame = 0;
    deathFinish = true;
  }
  if (!deathFinish) {
    image(deathFrames[deathFrame%300], c.deathX, c.deathY, 60,84);
    deathFrame++;
  }
  c.xPos += 40;
  c.yPos += c.deathSlope;
}
