public class Enemies {
  float xPos, yPos;
  float hitboxWidth, hitboxLength;
  float walkspeed;
  String type;
  boolean facingRight;
  PImage sprite;
  ArrayList<Projectiles> projectiles;
  
  public Enemies (String type, float xPos, float yPos, float hitboxWidth, float hitboxLength) {
    this.xPos = xPos;
    this.yPos = yPos;
    this.hitboxWidth = hitboxWidth;
    this.hitboxLength = hitboxLength;
    
    this.type = type;
    
    //walkspeed = [insert speed];
    //sprite = loadImage();
  }
  
  void move() {
  }
  
  void shoot() {
  }
  
  void display() {
    rect(xPos, yPos, hitboxWidth, hitboxLength);
  }
}
