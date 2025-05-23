public class Platforms {
  float xPos, yPos, width, height;
  
  public Platforms(float x, float y, float w, float h) {
    xPos = x;
    yPos = y;
    width = w;
    height = h;
  }
  
  void display() {
    rect(xPos, yPos, width, height);
  }
  
}
