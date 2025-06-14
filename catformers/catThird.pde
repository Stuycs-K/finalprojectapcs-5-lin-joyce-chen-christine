static PImage cat3idleR, cat3idleL, cat3shootR, cat3shootL;

public class catThird extends Character {
  
  public catThird (float walkspeed, float bulletspeed, int maxBulletCD, float xPos, float yPos) {
    super(walkspeed, bulletspeed, maxBulletCD, xPos, yPos);
    hitboxWidth = 51;
    hitboxLength = 75;
    projectileType = "grenade";
    
    if (cat3idleR == null) cat3idleR = loadImage("cat3idleR.png");
    if (cat3idleL == null) cat3idleL = loadImage("cat3idleL.png");
    if (cat3shootR == null) cat3shootR = loadImage("cat3shootR.png");
    if (cat3shootL == null) cat3shootL = loadImage("cat3shootL.png");
  }
  
  void flip() {
    if (facingRight) {
      if (shootTick > 0 && shootTick < 4) {
        sprite = cat3shootR;
        shootTick++;
      }
      else {
        sprite = cat3idleR;
        shootTick = 0;
      }
    }
    else {
      if (shootTick > 0 && shootTick < 4) {
        sprite = cat3shootL;
        shootTick++;
      }
      else {
        sprite = cat3idleL;
        shootTick = 0;
      }
    }
  }
  
  void shoot() {
    if (bulletCD == 0) {
    float mouthX;
    if (facingRight) {
      mouthX = xPos + hitboxWidth * 0.8;
    } else {
      mouthX = xPos + hitboxWidth * 0.2;
    }
    float mouthY = yPos+ hitboxLength * 0.47;
    
    // offset
    float offsetX = mouthX + cos(radians(aimAngle)) * 40;
    float offsetY = mouthY + sin(radians(aimAngle)) * 40;
    
    projectiles.add(new Projectiles("grenade", this, radians(aimAngle), bulletspeed, offsetX, offsetY));
    if (bulletMode) shootCount++;
    bulletCD = maxBulletCD;
    shootTick++;
    shootSound.play();
    }
  }
  
  void setAnimation() {
    if (facingRight) {
      if (shootTick > 0 && shootTick < 90) {
        PImage[] frames = cat3walkOpenR.getPImages();
        image(frames[cat3walkR.currentFrame()],  xPos, yPos, hitboxWidth+5, hitboxLength);
        shootTick++;
      }
      else {
        image(cat3walkR, xPos, yPos, hitboxWidth+5, hitboxLength);
        shootTick = 0;
      }
    }
    else {
      if (shootTick > 0 && shootTick < 90) {
        PImage[] frames = cat3walkOpenL.getPImages();
        image(frames[cat3walkL.currentFrame()],  xPos, yPos, hitboxWidth+5, hitboxLength);
        shootTick++;
      }
      else {
        image(cat3walkL, xPos, yPos, hitboxWidth+5, hitboxLength);
        shootTick = 0;
      }
    }
  }
  
  PImage getPreview() {
    if (isPlayerTwo && storyPhase) {
      return cat3idleL;
    }
    return cat3idleR;
  }
  
  void display() {
    // power ups
    boolean blink = false;
    if (miniMode && miniTick > 300) {
      if (miniTick % 20 < 10) blink = true;
    }
    applyBulletMode();
    applySlowMode();
    
    // line to check aim angles
    float angle = radians(aimAngle);
    float len = 40;
    float mouthX;
    if (facingRight) {
      mouthX = xPos + hitboxWidth * 0.8;
    } else {
      mouthX = xPos + hitboxWidth * 0.2;
    }
    float mouthY = yPos+ hitboxLength * 0.47;
    line(mouthX, mouthY, mouthX + cos(angle) * len, mouthY + sin(angle) * len);
        
    // display lives
    for (int x = 0; x < lives; x++) {
      image(heartImg, (width*chars.indexOf(this))+(pow(-1,chars.indexOf(this)+2))*(90+(40*chars.indexOf(this))+35*x), 35, 30,30);
    }
    flip();
    if (!blink) {
      if (!isWalking) {
        image(sprite, xPos, yPos, hitboxWidth, hitboxLength);
      }
      else {
        setAnimation();
      }
    }
    if (jumpCharge > 0) {
      displayJumpBar();
    }
  }
  
}
