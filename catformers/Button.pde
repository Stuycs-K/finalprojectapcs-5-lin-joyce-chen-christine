public class Button {
  float xPos, yPos;
  float buttonWidth, buttonHeight;
  String value;
  PImage display;
  boolean isToggle, toggleState;
  
  public Button (float xPos, float yPos, float buttonWidth, float buttonHeight, String value, String display) {
    this.xPos = xPos;
    this.yPos = yPos;
    this.buttonWidth = buttonWidth;
    this.buttonHeight = buttonHeight;
    this.value = value;
    this.display = loadImage(display);
    this.isToggle = false;
    this.toggleState = false;
  }
  
  // For Toggles
  public Button (float xPos, float yPos, float buttonWidth, float buttonHeight, String value) {
    this.xPos = xPos;
    this.yPos = yPos;
    this.buttonWidth = buttonWidth;
    this.buttonHeight = buttonHeight;
    this.value = value;
    this.display = null;
    this.isToggle = true;
    this.toggleState = false;
  }
  
  void display() {
    if (display != null) {
      image(display, xPos, yPos, buttonWidth, buttonHeight);
    } else {
      if (isToggle) {
        if (toggleState) {
          fill(0, 200, 0);
        } else {
          fill(200);
        }
      } else {
        fill(200);
      }
      rect(xPos, yPos, buttonWidth, buttonHeight);
      fill(0);
      text(value, xPos + buttonWidth/2, yPos + buttonWidth/2);
    }
  }
  
  void toggle() {
    if (isToggle) {
      toggleState = !toggleState;
    }
  }
  
}
