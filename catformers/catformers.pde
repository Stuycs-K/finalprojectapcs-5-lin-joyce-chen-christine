import gifAnimation.*;
import processing.sound.*;

ArrayList<Character> chars;
Character p1Char, p2Char;

ArrayList<Projectiles> projectiles;
ArrayList<Platforms> platforms;
ArrayList<Consumable> consumables;

Boss boss;
String currmode, numPlayer, prevMode;
boolean modeInitialized, selectScreen, demoMode, p1Chosen, p2Chosen, gameEnd, gamePause, deathFinish, mouseAim;
boolean restarted, transition, fadeOut;
float transitionTick;
int spawnTick;
screenSelect s;

// things for graphics
Gif start;
Gif death;
Gif spawnAnim;
PImage loading, title;
PImage bg1, bg2, bg1Dark;
PImage[] deathFrames;
int deathFrame;
PImage heartImg;
PImage warningSign;

// walk animations
Gif cat1walkR;
Gif cat1walkL;
Gif cat1walkOpenR;
Gif cat1walkOpenL;

Gif cat2walkR;
Gif cat2walkL;
Gif cat2walkOpenR;
Gif cat2walkOpenL;

Gif cat3walkR;
Gif cat3walkL;
Gif cat3walkOpenR;
Gif cat3walkOpenL;

//BGM 
SoundFile startBGM, bossBGM;
float bgmVolume;

// sound effects
SoundFile shootSound, hitSound, selectSound, explosion;

PVector mousePos = new PVector();

static float g = 3.5; // change gravity based on how fast we want them to fall!

final int MAX_KEY = 128;
final int MAX_KEYCODE = 256;
boolean[] p1Keys = new boolean[MAX_KEY];
boolean[] p2Keys = new boolean[MAX_KEYCODE];
boolean[] spamKeys = new boolean[MAX_KEYCODE];
boolean loaded = false;

void setup() {
  size(1280, 720);
  // Loading Screen (hide that gray thingy at the start)
  loading = loadImage("loadingScreen.png");
  background(loading);
}

void loadAssets() {  
  // graphicsss
  start = new Gif(this, "start.gif");
  spawnAnim = new Gif(this, "spawnAnim.gif");
  start.play();
  spawnAnim.play();
  title = loadImage("title.png");
  bg1 = loadImage("background1.png");
  bg1Dark = loadImage("darkBackground1.png");
  bg2 = loadImage("background2.png");
  
  heartImg = loadImage("heart.png");
  deathFrames = Gif.getPImages(this, "explosion.gif");
  
  warningSign = loadImage("warningSign.png");
  
  // walking animation
  cat1walkR = new Gif(this,"cat1walkR.gif");
  cat1walkL = new Gif(this,"cat1walkL.gif");
  cat1walkR.play();
  cat1walkL.play();
  
  cat2walkR = new Gif(this,"cat2walkR.gif");
  cat2walkL = new Gif(this,"cat2walkL.gif");
  cat2walkR.play();
  cat2walkL.play();
  
  cat3walkR = new Gif(this,"cat3walkR.gif");
  cat3walkL = new Gif(this,"cat3walkL.gif");
  cat3walkR.play();
  cat3walkL.play();
  
  // shooting frame
  cat1walkOpenR = new Gif(this, "cat1walkOpenR.gif");
  cat1walkOpenL = new Gif(this, "cat1walkOpenL.gif");
  cat1walkOpenR.play();
  cat1walkOpenL.play();
  
  cat2walkOpenR = new Gif(this, "cat2walkOpenR.gif");
  cat2walkOpenL = new Gif(this, "cat2walkOpenL.gif");
  cat2walkOpenR.play();
  cat2walkOpenL.play();
  
  cat3walkOpenR = new Gif(this, "cat3walkOpenR.gif");
  cat3walkOpenL = new Gif(this, "cat3walkOpenL.gif");
  cat3walkOpenR.play();
  cat3walkOpenL.play();
  
  // BGM
  startBGM = new SoundFile(this, "Bunny Bistro.mp3");
  bossBGM = new SoundFile(this, "Theme of Astrum Deus.mp3");
  
  // sound effects
  shootSound = new SoundFile(this, "popCat.wav"); 
  hitSound = new SoundFile(this, "catMeow1.wav");
  selectSound = new SoundFile(this, "selectSound.aiff");
  explosion = new SoundFile(this, "explosion.wav");
}

void loadState() {
  currmode = "Menu";
  numPlayer = "0";
  
  chars = new ArrayList<Character>();
  projectiles = new ArrayList<Projectiles>();
  platforms = new ArrayList<Platforms>();
  consumables = new ArrayList<Consumable>();
  s = new screenSelect();
  
  modeInitialized = false;
  selectScreen = false;
  p1Chosen = false;
  p2Chosen = false;
  gameEnd = false;
  gamePause = false;
  deathFrame = 0;
  deathFinish = false;
  transition = false;
  spawnTick = 0;
  
  if (bossBGM.isPlaying()) bossBGM.pause();

}
  
void draw() {
  
  if (!loaded) {
    loadAssets();
    loadState();
    loaded = true;
    return;
  }
  
  mousePos.set(mouseX, mouseY);
  
   if (currmode.equals("Boss")) {
    if (modeInitialized && (boss.phase == 1 || boss.phase == 2)) {
      background(bg1Dark); 
    } else {
      background(bg1);
    }
  }
  
  displayScreen();
  
  boolean gameOver = currmode.equals("Victory") || currmode.equals("Loss");
  for (Character c : chars) {
    if (c.isAlive && !gamePause && (!transition || fadeOut)) {
      if (!gameOver && c.bulletCD > 0) {
        c.bulletCD--;
      }
      if (!gameOver) {
        c.applyMovement();
      }
    }
    if (!gameEnd && (!transition || fadeOut)) {
      c.display();
    }
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
      if (currmode.equals("Boss") && numPlayer.equals("2")) {
        c.revivable = true;
      }
      c.deathSlope = random(-5,5) * 10.0;
      while (c.deathSlope == 0.0) {
        c.deathSlope = random(-5,5) * 10.0;
      }
      c.deathX = c.xPos;
      c.deathY = c.yPos;
      gameEnd = true;
    }
    
    if (!gameEnd) {
    
      if(c.isAlive && c.isTrapped) {
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
      
      if (c.isAlive && c.inverseControls) {
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
      
      if (!c.isAlive && c.revivable) {
        pushStyle();
        float bW = 160;
        float bH = 35;
        fill(0, 0, 0, 120);
        noStroke();
        rect(c.xPos + c.hitboxWidth/2 - bW/2, c.yPos - 50, bW, bH, 8);
        textAlign(CENTER, CENTER);
        textSize(16);
        fill(255);
        text("Spam JUMP Over Me", c.xPos + c.hitboxWidth/2, c.yPos - 40);
        text("To REVIVE!", c.xPos + c.hitboxWidth/2, c.yPos - 26);      
        popStyle();
      }
      
    }
    
  }
  
  if (currmode.equals("Boss") && !transition) {
    if (boss.spawned || spawnTick == 300) {
      if (!boss.spawned) boss.spawned = true;
      if (!bossBGM.isPlaying()) {
        bossBGM.amp(0.2);
        bossBGM.play();
      }
      boss.update();
      boss.display();
    } else if (spawnTick > 40) {
      image(spawnAnim, boss.xPos-boss.hitboxWidth/2, boss.yPos-boss.hitboxLength/2-25, 200, 200);
      spawnTick++;
    } else spawnTick++;
  }    
  
  if (transition) {
    transitionScreen();
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
    if (currmode.equals("Menu") && !restarted) {
      selectScreen = true;
    }
    else if (currmode.equals("Versus") || currmode.equals("Boss")) {
      if (!gamePause && !transition) {
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
            if (p1Keys['d'] || p1Keys['a']) {
              chars.get(0).horizontalJump = true;
            } else {
              chars.get(0).horizontalJump = false;
            }
            chars.get(0).addJumpCharge();
          }
          else if (p1Keys['s']) {
            chars.get(0).crouch();
          }
          if (p1Keys['q']) {
            chars.get(0).aim(true);
            mouseAim = false;
          } else if (p1Keys['e']) {
            chars.get(0).aim(false);
            mouseAim = false;
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
    if ((currmode.equals("Boss")) && numPlayer.equals("2")) {
      if (!p1Char.isAlive && p1Char.revivable && p2Char.isAlive) {
        if (p2Keys[UP] && !spamKeys[UP]) {
          if (p2Char.xPos + p2Char.hitboxWidth > p1Char.xPos && p2Char.xPos < p1Char.xPos + p1Char.hitboxWidth &&
          p2Char.yPos + p2Char.hitboxLength > p1Char.yPos && p2Char.yPos < p1Char.yPos + p1Char.hitboxLength) {
            p1Char.spamCount++;
            if (p1Char.spamCount >= 5) {
              p1Char.isAlive = true;
              p1Char.revivable = false;
              p1Char.lives = 1;
              p1Char.spamCount = 0;
              p1Char.yPos += 10;
            }
          }
        }
      }
      if (!p2Char.isAlive && p2Char.revivable && p1Char.isAlive) {
        if (p1Keys['w'] && !spamKeys['w']) {
          if (p1Char.xPos + p1Char.hitboxWidth > p2Char.xPos && p1Char.xPos < p2Char.xPos + p2Char.hitboxWidth &&
          p1Char.yPos + p1Char.hitboxLength > p2Char.yPos && p1Char.yPos < p2Char.yPos + p2Char.hitboxLength) {
            p2Char.spamCount++;
            if (p2Char.spamCount >= 5) {
              p2Char.isAlive = true;
              p2Char.revivable = false;
              p2Char.lives = 1;
              p2Char.spamCount = 0;
              p2Char.yPos += 10;
            }
          }
        }
      }
    }
        
  }
  
  if (currmode.equals("Boss") && numPlayer.equals("1") && !gamePause && !gameEnd &&
  chars.get(0).isAlive && !chars.get(0).isTrapped) {
    if (mouseAim) {
      chars.get(0).mouseAim(mousePos);
    }
  }

}

void mouseMoved() {
  mouseAim = true;
}

void keyPressed() {
  if (currmode.equals("CharacterSelect")) {
    if (!p1Chosen) {
      if (key == 'a' || key == 'A') s.p1Index = (s.p1Index + s.charOptions.size() - 1) % s.charOptions.size();
      if (key == 'd' || key == 'D') s.p1Index = (s.p1Index + 1) % s.charOptions.size();
      if (key == 'w' || key == 'W') {
        p1Char = s.generateChar(s.p1Index);
        p1Chosen = true;
      }
    } else if (key == 'w' || key == 'W') {
      p1Chosen = false;
    }
    if (numPlayer.equals("2") && !p2Chosen) {
      if (keyCode == LEFT) s.p2Index = (s.p2Index + s.charOptions.size() - 1) % s.charOptions.size();
      if (keyCode == RIGHT) s.p2Index = (s.p2Index + 1) % s.charOptions.size();
      if (keyCode == UP) {
        p2Char = s.generateChar(s.p2Index);
        p2Chosen = true;
      }
    } else if (p2Chosen && keyCode == UP) {
      p2Chosen = false;
    }
    if (keyCode == ENTER && ((numPlayer.equals("1") && p1Chosen) || (numPlayer.equals("2") && p1Chosen && p2Chosen))) {
      p1Char.startX = 100;
      p1Char.xPos = p1Char.startX;
      chars.add(p1Char);
      if (numPlayer.equals("2")) {
        p2Char.isPlayerTwo = true;
        p2Char.startX = 1150;
        p2Char.xPos = p2Char.startX;
        p2Char.facingRight = false;
        p2Char.aimAngle = 180;
        chars.add(p2Char);
      }
      transition = true;
      transitionTick = 0;
      fadeOut = false;
      selectSound.jump(0.5);
      selectSound.play();
      transitionScreen();
      modeInitialized = false;
    }
  }
    
  if (key < MAX_KEY) p1Keys[key] = true;
  if (keyCode < MAX_KEYCODE) p2Keys[keyCode] = true;
  
  if (!gameEnd) {
    if (keyCode < MAX_KEYCODE && !spamKeys[keyCode]) {
      spamKeys[keyCode] = true;
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
  }
  
  if (currmode.equals("Victory") || currmode.equals("Loss")) {
    if (keyCode == ENTER || keyCode == RETURN) {
      loadState();
      restarted = true;
    }
  }

}

void keyReleased() {
  if (key < MAX_KEY) p1Keys[key] = false;
  if (keyCode < MAX_KEYCODE) p2Keys[keyCode] = false;
  if (keyCode < MAX_KEYCODE) spamKeys[keyCode] = false;
  
  if (currmode.equals("Versus") || currmode.equals("Boss")) {
      if (key == ' ' && !transition) {
        gamePause = !gamePause;
        if (currmode.equals("Boss")) {
          if (bossBGM.isPlaying()) bossBGM.pause();
          else bossBGM.play();
        }
      }
     if (!gamePause && !transition) {
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
  if (currmode.equals("Menu") && restarted) {
    restarted = false;
  }
}

void mouseClicked() {
  if (selectScreen) {
    s.buttonClicked();
  }
  if (gamePause) {
    if (mouseX >= width/2 - 32 && mouseX <= width/2 + 32 &&
          mouseY >= height/1.80 - 20 && mouseY <= height/1.80 + 20) {
      loadState();
    }
    if (mouseX >= width/2 - 55 && mouseX <= width/2 + 55 &&
          mouseY >= height/1.60 - 20 && mouseY <= height/1.60 + 20) {
      restartGame();
    }
  }
}

void displayScreen() {
  if (currmode.equals("Menu")) {
    if (!selectScreen) {
      bgmVolume = 0.6;
      if (!startBGM.isPlaying()) {
        startBGM.loop();
        startBGM.amp(bgmVolume);
      }
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
      if (bgmVolume != 0.2) {
        bgmVolume = 0.2;
        startBGM.amp(bgmVolume);
      }
    }
  } else if (currmode.equals("MapSelect")) {
    s.display();
  } else if (currmode.equals("CharacterSelect")) {
    s.display();
  }
  else if (currmode.equals("Versus")) {
    prevMode = "Versus";
    if (s.selectedMap.equals("Map2")) {
      background(bg2);
    } else {
      background(bg1);
    }
    image(loadImage("p1.png"), 20, 30, 60, 44.4);
    image(loadImage("p2.png"), width-90, 30, 60, 44.4);
    if (!modeInitialized) {
      if (startBGM.isPlaying()) {
        startBGM.pause();
      }
      modeInitialized = true;
      
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
    prevMode = "Boss";
    image(loadImage("p1.png"), 20, 30, 60, 44.4);
    if (numPlayer.equals("2")) {
      image(loadImage("p2.png"), width-90, 30, 60, 44.4);
    }
    
    if (!modeInitialized) {
      if (startBGM.isPlaying()) {
        startBGM.pause();
      }
      modeInitialized = true;
      boss = new Boss(640, height - 522);
      
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
    
    if (boss.timer % 800 == 0 && boss.timer != 0) {
      Platforms p = platforms.get((int)(random(0,platforms.size())));
      consumables.add(new Consumable(random(p.xPos,p.xPos+p.platformWidth+1), p.yPos-42, 20, 28));
    }
    
    for (int x = 0; x < consumables.size(); x++) {
      Consumable C = consumables.get(x);
      C.display();
      for (Character c : chars) {
        if (C.checkUse(c)) {
          consumables.remove(C);
          x--;
        }
      }
    }
    
    int deathCount = 0;
    for (Character c : chars) {
      if (numPlayer.equals("2")) {
        if (!p1Char.isAlive && !p2Char.isAlive) {
          p1Char.revivable = false;
          p2Char.revivable = false;
        }
      }
      if (!c.isAlive && !c.revivable) {
        deathCount+=1; 
      }
      if (!c.isAlive) {
        deathAnimation(c);
      }
    }
    if (deathCount == chars.size()) {
      gameEnd = true;
      currmode = "Loss";
    } else {
      deathCount = 0;
    }
    
    if (boss.lives <= 0) {
      gameEnd = true;
      currmode = "Victory";
    }
  }
  else if (currmode.equals("Loss")) {
    if (bossBGM.isPlaying()) {
      bossBGM.pause();
    }
    image(bg1, 0, 0, width, height);
    image(loadImage("p1.png"), 20, 30, 60, 44.4);
    if (numPlayer.equals("2")) {
      image(loadImage("p2.png"), width-90, 30, 60, 44.4);
    }
    
    for (Platforms p : platforms) {
      p.display();
    }
    for (Character c : chars) {
      deathAnimation(c);
      c.display();
    }

    boss.update();
    boss.display();
    
    fill(0);
    stroke(255);
    strokeWeight(5);
    rect(width/3.25, height/3.25, 500, 300);
    strokeWeight(1);
    stroke(0);
    
    fill(255);
    textSize(80);
    text("You Lose :(",width/2, height/2);
    
    textSize(20);
    text("press [enter] to return to start screen",width/2, height/1.50);
  }
  else if (currmode.equals("Victory")) {
    image(bg1, 0, 0, width, height);
    image(loadImage("p1.png"), 20, 30, 60, 44.4);
    image(loadImage("p2.png"), width-90, 30, 60, 44.4);
    for (Platforms p : platforms) {
      p.display();
    }
    for (Character c : chars) {
      c.display();
    }
    if (prevMode.equals("Versus")) {
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
    } else {
      if (bossBGM.isPlaying()) {
        bossBGM.pause();
      }
      boss.update();
      boss.display();
      fill(0);
      stroke(255);
      strokeWeight(5);
      rect(width/3.25, height/3.25, 500, 300);
      strokeWeight(1);
      stroke(0);
      
      fill(255);
      textSize(80);
      text("You Win :D",width/2, height/2);
    }
    
    textSize(20);
    text("press [enter] to return to start screen",width/2, height/1.50);
  }
}

void restartGame() {
  projectiles.clear();
  platforms.clear();
  consumables.clear();
  
  if (currmode.equals("Boss")) {
    boss = null;
  }
  
  for (Character c : chars) {
    c.reset();
  }

  modeInitialized = false;
  gameEnd = false;
  gamePause = false;
  deathFrame = 0;
  deathFinish = false;
  bossBGM.jump(0);
}

void deathAnimation(Character c) {
  if (prevMode.equals("Versus")) {
    if (deathFrame == 17) {
      deathFrame = 0;
      deathFinish = true;
    }
    if (!deathFinish) {
      if (!explosion.isPlaying() && deathFrame == 0) {
        explosion.jump(0.2);
        explosion.amp(0.5);
        explosion.play();
      }
      image(deathFrames[deathFrame%300], c.deathX, c.deathY, 60,84);
      deathFrame++;
    }
    c.xPos += 40;
    c.yPos += c.deathSlope;
  } else {
    if (numPlayer.equals("2")) {
      if (!p1Char.revivable && !p2Char.revivable) {
        c.yPos -=5.0;
      } else {
        c.yPos -= .5;
      }
    } else {
      c.yPos -= 5;
    }
    if (c.yPos + c.hitboxLength < 0) {
      c.revivable = false;
    }
  }
}

void transitionScreen() {
  fill(0,transitionTick);
  rect(0,0,width,height);
  fill(255,255);
  if (transitionTick < 255 && !fadeOut) {
    transitionTick+=5;
    if (bgmVolume != 0) {
      bgmVolume -= 0.005;
      startBGM.amp(bgmVolume);
    }
  } else if (transitionTick > 0) {
    if (!modeInitialized) currmode = s.selectedMode;
    fadeOut = true;
    transitionTick-=5;
  } else {
    transition = false;
    fadeOut = false;
  }
}
