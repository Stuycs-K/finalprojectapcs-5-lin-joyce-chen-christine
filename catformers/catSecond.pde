static PImage cat2idleR, cat2idleL, cat2shootR, cat2shootL;

public class catSecond extends Character {
  
  /*public firstcat(float xPos, float yPos) {
    this(, , , , , xPos, yPos); //fill this outtt
  }*/
  
  public catSecond (float walkspeed, float bulletspeed, int maxBulletCD, float xPos, float yPos) {
    super(walkspeed, bulletspeed, maxBulletCD, xPos, yPos);
    
    if (cat2idleR == null) cat2idleR = loadImage("cat2idleR.png");
    if (cat2idleL == null) cat2idleL = loadImage("cat2idleL.png");
    if (cat2shootR == null) cat2shootR = loadImage("cat2shootR.png");
    if (cat2shootL == null) cat2shootL = loadImage("cat2shootL.png");
  }
  
  void flip() {
    if (facingRight) {
      sprite = cat2idleR;
    }
    else {
      sprite = cat2idleL;
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
    bulletCD = maxBulletCD;
    }
  }
  
  /*void setAnimation() {
    if (facingRight) {
      image(cat2walkR, xPos, yPos, hitboxWidth, hitboxLength);
    }
    else {
      image(cat2walkL, xPos, yPos, hitboxWidth, hitboxLength);
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
