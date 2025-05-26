public class firstcat extends Character {
  
  /*public firstcat(float xPos, float yPos) {
    this(, , , , , xPos, yPos); //fill this outtt
  }*/
  
  public firstcat (float walkspeed, float bulletspeed, int maxBulletCD, float xPos, float yPos) {
    super(walkspeed, bulletspeed, maxBulletCD, xPos, yPos);
  }
  
  void flip() {
    if (facingRight) {
      sprite = loadImage("cat1idleR.png");
    }
    else {
      sprite = loadImage("cat1idleL.png");
    }
  }
  
  void setAnimation() {
    if (facingRight) {
      image(cat1walkR, xPos, yPos, hitboxWidth, hitboxLength);
    }
    else {
      image(cat1walkL, xPos, yPos, hitboxWidth, hitboxLength);
    }
  }
  
  void display() {
    // line to check aim angles
    float angle = radians(aimAngle);
    float len = 40;
    line(xPos, yPos, xPos + cos(angle) * len, yPos + sin(angle) * len);
    
    flip();
    if (!isWalking) {
      image(sprite, xPos, yPos, hitboxWidth, hitboxLength);
    }
    else {
      setAnimation();
    }
  }
  
}
