public class secondcat extends Character {
  
  /*public firstcat(float xPos, float yPos) {
    this(, , , , , xPos, yPos); //fill this outtt
  }*/
  
  public secondcat (float walkspeed, float bulletspeed, int maxBulletCD, float xPos, float yPos) {
    super(walkspeed, bulletspeed, maxBulletCD, xPos, yPos);
  }
  
  void flip() {
    if (facingRight) {
      sprite = loadImage("cat2idleR.png");
    }
    else {
      sprite = loadImage("cat2idleL.png");
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
      image(loadImage("heart.png"), 90+35*x, 35+50*(chars.indexOf(this)), 30,30);
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
