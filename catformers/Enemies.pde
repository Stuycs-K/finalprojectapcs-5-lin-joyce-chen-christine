public class Enemies {
  float xPos, yPos;
  float hitboxWidth, hitboxLength;
  float walkspeed;
  float moveX, moveY;
  int lives, maxLives, moveTick, shootTick;
  boolean facingRight, isAlive;
  PImage sprite;
  
  public Enemies (float xPos, float yPos, float hitboxWidth, float hitboxLength) {
    this.xPos = xPos;
    this.yPos = yPos;
    this.hitboxWidth = hitboxWidth;
    this.hitboxLength = hitboxLength;
    
    lives = 3;
    maxLives = lives;
    
    walkspeed = 6;
    moveTick = 0;
    facingRight = false;
    
    
    sprite = loadImage("enemyIdle.png");
  }
  
  void move() {
    if (moveTick < 150) {
      xPos += moveX;
      yPos += moveY;
      moveTick++;
    } else {
      moveTick = 0;
      moveX = walkspeed * (-1 + random(0,2));
      moveY = walkspeed * (-1 + random(0,2));
      xPos += moveX;
      yPos += moveY;
    }
    checkBorder();
  }
  
  void checkBorder() {
    if (!(xPos + moveX > width/3 && xPos + hitboxWidth + moveX < width)) moveX *= -1;
    if (!(yPos + moveY > 0 && yPos + hitboxLength + moveY < height - 20)) moveY *= -1;
  }
  
  void shoot() {
    Character c = chars.get((int)(random(0,chars.size())));
    float mouthY = yPos + hitboxLength/2;
    projectiles.add(new Projectiles("enemy", null, getAngle(c), 15, xPos, mouthY)); 
  }
  
  float getAngle(Character c) {
    float refAngle = atan(abs(c.yPos/c.xPos));
    if (c.xPos < 0) {
      if (c.yPos < 0) return 180 + refAngle;
      else return 180 - refAngle;
    } else {
      if (c.yPos < 0) return 360 - refAngle;
      else return refAngle;
    }
  }
  
  void display() {
    move();
    
    pushStyle();
    int hpBarWidth = (int)(hitboxWidth+20);
    int hpBarHeight = 10;
    lives = max(0, lives);
    float hpPercent = (float) lives / maxLives;
    float hpY;
    if (yPos - hitboxLength/2 - 20 < 0) {
      hpY = yPos + hitboxLength/2 + 10;
    } else {
      hpY = yPos - hitboxLength/2 - 20;
    }
    fill (100);
    rect(xPos - hpBarWidth/2, hpY, hpBarWidth, hpBarHeight);
    fill(50, 205, 50);
    rect(xPos - hpBarWidth/2, hpY, hpBarWidth * hpPercent, hpBarHeight);
    popStyle();
    
    image(sprite, xPos - hitboxWidth/2, yPos - hitboxLength/2, hitboxWidth, hitboxLength);
  }
}
