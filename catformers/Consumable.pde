public class Consumable {
  PImage img;
  float xPos, yPos, Width, Length;
  
  public Consumable (float xPos, float yPos, float Width, float Length) {
    img = loadImage("hpPotion.png");
    this.xPos = xPos;
    this.yPos = yPos;
    this.Width = Width;
    this.Length = Length;
  }
  
  boolean checkUse(Character c) {
    if (xPos < c.xPos + c.hitboxWidth && xPos + Width > c.xPos && 
          yPos < c.yPos + c.hitboxLength && yPos + Length > c.yPos &&
          c.lives < c.maxLives) {
      c.lives+=1;
      return true;
    }
    return false;
  }
  
  void display() {
    image(img, xPos, yPos, Width, Length);
  }
}
