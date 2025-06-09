public class Enemies {
  float xPos, yPos;
  float hitboxWidth, hitboxLength;
  float walkspeed;
  float moveX, moveY;
  int lives, maxLives, moveTick, shootTick;
  boolean facingRight, isAlive;
  PImage sprite;
  ArrayList<Projectiles> enemyProjectiles; 
  
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
    
    enemyProjectiles = new ArrayList<Projectiles>();
    sprite = loadImage("enemyIdle.png");
  }
  
  void move() {
    if (moveTick == 0) { 
      moveX = walkspeed * (-1 + random(0,2));
      moveY = walkspeed * (-1 + random(0,2));
    }
    xPos += moveX;
    yPos += moveY;
    moveTick++;
    if (moveTick >= 150) {
      moveTick = 0;
    }
    checkBorder();
    
    shootTick++;
    if (shootTick % 90 == 0) {
      shoot();
    }
  }
  
  void checkBorder() {
    if (!(xPos + moveX > width/3 && xPos + hitboxWidth + moveX < width)) moveX *= -1;
    if (!(yPos + moveY > 0 && yPos + hitboxLength + moveY < height - 20)) moveY *= -1;
  }
  
  void shoot() {
    Character c = chars.get((int)(random(0,chars.size())));
    float mouthY = yPos + hitboxLength/2;
    enemyProjectiles.add(new Projectiles("enemy", null, getAngle(c), 10, xPos, mouthY)); 
  }
  
  float getAngle(Character c) {
    return atan2(c.yPos - yPos, c.xPos - xPos);
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
