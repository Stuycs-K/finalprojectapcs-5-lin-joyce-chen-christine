public class Consumable {
  PImage img;
  float xPos, yPos, Width, Length;
  String type;
  
  public Consumable (String type, float xPos, float yPos, float Width, float Length) {
    this.type = type;
    this.xPos = xPos;
    this.yPos = yPos;
    this.Width = Width;
    this.Length = Length;
    
    if (type.equals("hpPotion")) img = loadImage("hpPotion.png");
    if (type.equals("miniPotion")) img = loadImage("miniPotion.png");
    if (type.equals("bulletPotion")) img = loadImage("bulletPotion.png");
  }
  
  boolean checkUse(Character c) {
    if (type.equals("hpPotion")) {
      if (xPos < c.xPos + c.hitboxWidth && xPos + Width > c.xPos && 
            yPos < c.yPos + c.hitboxLength && yPos + Length > c.yPos &&
            c.lives < c.maxLives && c.isAlive) {
        c.lives+=1;
        return true;
      }
    } else if (type.equals("miniPotion")) {
      if (xPos < c.xPos + c.hitboxWidth && xPos + Width > c.xPos && 
            yPos < c.yPos + c.hitboxLength && yPos + Length > c.yPos &&
            c.isAlive) {
        c.miniMode = true;
        return true;
      }
    }
    return false;
  }
  
  void display() {
    image(img, xPos, yPos, Width, Length);
  }
}
