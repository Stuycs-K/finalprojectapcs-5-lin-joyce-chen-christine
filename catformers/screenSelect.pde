public class screenSelect {
  ArrayList<Button> modes = new ArrayList<Button>();
  ArrayList<Character> charOptions = new ArrayList<Character>();
  
  public screenSelect() {
    modes.add(new Button(width/2-400,height/2-150,300,300, "Versus", "versus.png"));
    modes.add(new Button(width/2+100,height/2-150,300,300, "Boss", "boss.png"));
  }
  
  void buttonClicked() {
    if (modes.size() == 2) {
      for (int x = 0; x < modes.size(); x++) {
        Button b = modes.get(x);
        if (mouseX >= b.xPos && mouseX <= b.xPos + b.buttonWidth &&
              mouseY >= b.yPos && mouseY <= b.yPos + b.buttonHeight) {
          currmode = modes.remove(x).value;
        }
      }
    }
  }
  
  void display() {
    if (modes.size() == 2) {
      for (Button b : modes) {
        b.display();
      }
    }
  }
  
}
