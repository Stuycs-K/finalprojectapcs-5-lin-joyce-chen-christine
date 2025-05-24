public class Button {
  float xPos, yPos;
  float buttonWidth, buttonHeight;
  String value;
  PImage display;
  
  public Button (float xPos, float yPos, float buttonWidth, float buttonHeight, String value, String display) {
    this.xPos = xPos;
    this.yPos = yPos;
    this.buttonWidth = buttonWidth;
    this.buttonHeight = buttonHeight;
    this.value = value;
    this.display = loadImage(display);
  }
  
  void display() {
    image(display, xPos, yPos, buttonWidth, buttonHeight);
  }
}
