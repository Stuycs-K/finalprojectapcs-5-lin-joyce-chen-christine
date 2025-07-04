static PImage cat2idleR, cat2idleL, cat2shootR, cat2shootL;

public class catSecond extends Character {
  
  public catSecond (float walkspeed, float bulletspeed, int maxBulletCD, float xPos, float yPos) {
    super(walkspeed, bulletspeed, maxBulletCD, xPos, yPos);
    hitboxWidth = 50;
    hitboxLength = 77;
    projectileType = "laser";
    
    if (cat2idleR == null) cat2idleR = loadImage("cat2idleR.png");
    if (cat2idleL == null) cat2idleL = loadImage("cat2idleL.png");
    if (cat2shootR == null) cat2shootR = loadImage("cat2shootR.png");
    if (cat2shootL == null) cat2shootL = loadImage("cat2shootL.png");
  }
  
  void flip() {
    if (facingRight) {
      if (shootTick > 0 && shootTick < 4) {
        sprite = cat2shootR;
        shootTick++;
      }
      else {
        sprite = cat2idleR;
        shootTick = 0;
      }
    }
    else {
      if (shootTick > 0 && shootTick < 4) {
        sprite = cat2shootL;
        shootTick++;
      }
      else {
        sprite = cat2idleL;
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
    
    projectiles.add(new Projectiles("laser", this, radians(aimAngle), bulletspeed, mouthX, mouthY));
    if (bulletMode) shootCount++;
    bulletCD = maxBulletCD;
    shootTick++;
    shootSound.play();
    }
  }
  
  void setAnimation() {
    if (facingRight) {
      if (shootTick > 0 && shootTick < 90) {
        PImage[] frames = cat2walkOpenR.getPImages();
        image(frames[cat2walkR.currentFrame()],  xPos, yPos, hitboxWidth+5, hitboxLength);
        shootTick++;
      }
      else {
        image(cat2walkR, xPos, yPos, hitboxWidth+5, hitboxLength);
        shootTick = 0;
      }
    }
    else {
      if (shootTick > 0 && shootTick < 90) {
        PImage[] frames = cat2walkOpenL.getPImages();
        image(frames[cat2walkL.currentFrame()],  xPos, yPos, hitboxWidth+5, hitboxLength);
        shootTick++;
      }
      else {
        image(cat2walkL, xPos, yPos, hitboxWidth+5, hitboxLength);
        shootTick = 0;
      }
    }
  }
  
  PImage getPreview() {
    if (isPlayerTwo && storyPhase) {
      return cat2idleL;
    }
    return cat2idleR;
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
