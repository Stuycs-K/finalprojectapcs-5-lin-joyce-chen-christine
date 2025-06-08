public class Enemies {
  float xPos, yPos;
  float hitboxWidth, hitboxLength;
  float walkspeed;
  int lives;
  String type;
  boolean facingRight, isAlive;
  PImage sprite;
  ArrayList<Projectiles> projectiles;
  
  public Enemies (String type, float xPos, float yPos, float hitboxWidth, float hitboxLength) {
    this.xPos = xPos;
    this.yPos = yPos;
    this.hitboxWidth = hitboxWidth;
    this.hitboxLength = hitboxLength;
    this.type = type;
    
    walkspeed = 1.5;
    facingRight = false;
    projectiles = new ArrayList<Projectiles>();
    
    
    sprite = loadImage("enemyIdle.png");
  }
  
  void move() {
  }
  
  void shoot() {
  }
  
  void display() {
    image(sprite, xPos - hitboxWidth/2, yPos - hitboxLength/2, hitboxWidth, hitboxLength);
  }
}
