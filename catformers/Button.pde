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
      drawToggle();
    }
  }
  
  void drawToggle () {
    if (toggleState == true) {
      fill(100, 255, 100);
    } else {
      fill(200);
    }
    noStroke();
    rect(xPos, yPos, buttonWidth, buttonHeight, buttonHeight);

    float circleX;
    if (toggleState == true) {
      circleX = xPos + buttonWidth - buttonHeight/2;
    } else {
      circleX = xPos + buttonHeight/2;
    }
    fill(255);
    ellipse(circleX, yPos + buttonHeight/2, buttonHeight*0.8, buttonHeight*0.8);
    
    fill(255);
    textSize(20);
    text(value, xPos - 63, yPos + buttonHeight/2);
  }

  void toggle() {
    if (isToggle) {
      toggleState = !toggleState;
    }
  }
  
}
