public class Enemies {
  float xPos, yPos;
  float hitboxWidth, hitboxLength;
  float walkspeed;
  float moveX, moveY;
  int lives, moveTick;
  boolean facingRight, isAlive;
  PImage sprite;
  ArrayList<Projectiles> projectiles;
  
  public Enemies (float xPos, float yPos, float hitboxWidth, float hitboxLength) {
    this.xPos = xPos;
    this.yPos = yPos;
    this.hitboxWidth = hitboxWidth;
    this.hitboxLength = hitboxLength;
    
    walkspeed = 6;
    moveTick = 0;
    facingRight = false;
    projectiles = new ArrayList<Projectiles>();
    
    
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
  }
  
  void display() {
    move();
    image(sprite, xPos - hitboxWidth/2, yPos - hitboxLength/2, hitboxWidth, hitboxLength);
  }
}
