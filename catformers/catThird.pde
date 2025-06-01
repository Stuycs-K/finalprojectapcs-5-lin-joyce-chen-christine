static PImage cat3idleR, cat3idleL, cat3shootR, cat3shootL;

public class catThird extends Character {
  
  /*public firstcat(float xPos, float yPos) {
    this(, , , , , xPos, yPos); //fill this outtt
  }*/
  
  public catThird (float walkspeed, float bulletspeed, int maxBulletCD, float xPos, float yPos) {
    super(walkspeed, bulletspeed, maxBulletCD, xPos, yPos);
    
    if (cat3idleR == null) cat3idleR = loadImage("cat3idleR.png");
    if (cat3idleL == null) cat3idleL = loadImage("cat3idleL.png");
    if (cat3shootR == null) cat3shootR = loadImage("cat3shootR.png");
    if (cat3shootL == null) cat3shootL = loadImage("cat3shootL.png");
  }
  
  void flip() {
    if (facingRight) {
      sprite = cat3idleR;
    }
    else {
      sprite = cat3idleL;
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
    
    projectiles.add(new Projectiles("grenade", this, radians(aimAngle), bulletspeed, mouthX, mouthY));
    bulletCD = maxBulletCD;
    }
  }
  
  /*void setAnimation() {
    if (facingRight) {
      image(cat3walkR, xPos, yPos, hitboxWidth, hitboxLength);
    }
    else {
      image(cat3walkL, xPos, yPos, hitboxWidth, hitboxLength);
    }
  }*/
  
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
    float mouthY = yPos+ hitboxLength * 0.47;
    line(mouthX, mouthY, mouthX + cos(angle) * len, mouthY + sin(angle) * len);
        
    // display lives
    for (int x = 0; x < lives; x++) {
      image(heartImg, 90+35*x, 35+50*(chars.indexOf(this)), 30,30);
    }
    flip();
    if (!isWalking) {
      image(sprite, xPos, yPos, hitboxWidth, hitboxLength);
    }
    else {
      //setAnimation();
    }
    if (jumpCharge > 0) {
      displayJumpBar();
    }
  }
  
}
