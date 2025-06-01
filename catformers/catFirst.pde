static PImage cat1idleR, cat1idleL, cat1shootR, cat1shootL;

public class catFirst extends Character {
    
  /*public firstcat(float xPos, float yPos) {
    this(, , , , , xPos, yPos); //fill this outtt
  }*/
  
  public catFirst (float walkspeed, float bulletspeed, int maxBulletCD, float xPos, float yPos) {
    super(walkspeed, bulletspeed, maxBulletCD, xPos, yPos);
    
    if (idleR == null) cat1idleR = loadImage("cat1idleR.png");
    if (idleL == null) cat1idleL = loadImage("cat1idleL.png");
    if (shootR == null) cat1shootR = loadImage("cat1shootR.png");
    if (shootL == null) cat1shootL = loadImage("cat1shootL.png");
  }
  
  void flip() {
    if (facingRight) {
      if (shootTick > 0 && shootTick < 4) {
        sprite = cat1shootR;
        shootTick++;
      }
      else {
        sprite = cat1idleR;
        shootTick = 0;
      }
    }
    else {
      if (shootTick > 0 && shootTick < 4) {
        sprite = cat1shootL;
        shootTick++;
      }
      else {
        sprite = cat1idleL;
        shootTick = 0;
      }
    }
  }
  
  void setAnimation() {
    if (facingRight) {
      if (shootTick > 0 && shootTick < 90) {
        PImage[] frames = cat1walkOpenR.getPImages();
        image(frames[cat1walkR.currentFrame()],  xPos, yPos, hitboxWidth, hitboxLength);
        shootTick++;
      }
      else {
        image(cat1walkR, xPos, yPos, hitboxWidth, hitboxLength);
        shootTick = 0;
      }
    }
    else {
      if (shootTick > 0 && shootTick < 90) {
        PImage[] frames = cat1walkOpenL.getPImages();
        image(frames[cat1walkL.currentFrame()],  xPos, yPos, hitboxWidth, hitboxLength);
        shootTick++;
      }
      else {
        image(cat1walkL, xPos, yPos, hitboxWidth, hitboxLength);
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
    
    projectiles.add(new Projectiles("normal", this, radians(aimAngle), bulletspeed, mouthX, mouthY));
    bulletCD = maxBulletCD;
    shootTick++;
    }
  }
  
  void display() {

    // line to check aim angles
    float angle = radians(aimAngle);
    float len = 40;
    float mouthX;
    if (facingRight) {
      mouthX = xPos + hitboxWidth * 0.8;
    } else {
      mouthX = xPos + hitboxWidth * 0.2;
    }
    float mouthY = yPos+ hitboxLength * 0.35;
    line(mouthX, mouthY, mouthX + cos(angle) * len, mouthY + sin(angle) * len);
        
    // display lives
    for (int x = 0; x < lives; x++) {
      image(heartImg, (width*chars.indexOf(this))+(pow(-1,chars.indexOf(this)+2))*(90+(40*chars.indexOf(this))+35*x), 35, 30,30);
    }
    flip();
    if (!isWalking) {
      image(sprite, xPos, yPos, hitboxWidth, hitboxLength);
    }
    else {
      setAnimation();
    }
    if (jumpCharge > 0) {
      displayJumpBar();
    }
  }
  
}
