public class screenSelect {
  ArrayList<Button> modes = new ArrayList<Button>();
  ArrayList<Button> numPlayers = new ArrayList<Button>();
  ArrayList<Character> charOptions = new ArrayList<Character>();
  
  String selectedMode;
  
  public screenSelect() {
    modes.add(new Button(width/2-400,height/2-150,300,300, "Versus", "versus.png"));
    modes.add(new Button(width/2+100,height/2-150,300,300, "Boss", "boss.png"));
    
    numPlayers.add(new Button(width/2-400,height/2-150,300,300, "1", "onep.png"));
    numPlayers.add(new Button(width/2+100,height/2-150,300,300, "2", "twop.png"));
  }
  
  void buttonClicked() {
    if (modes.size() == 2) {
      for (int x = 0; x < modes.size(); x++) {
        Button b = modes.get(x);
        if (mouseX >= b.xPos && mouseX <= b.xPos + b.buttonWidth &&
              mouseY >= b.yPos && mouseY <= b.yPos + b.buttonHeight) {
          selectedMode = modes.remove(x).value;
        }
      }
    }
    else if (selectedMode.equals("Boss")) {
      for (int x = 0; x < numPlayers.size(); x++) {
        Button b = numPlayers.get(x);
        if (mouseX >= b.xPos && mouseX <= b.xPos + b.buttonWidth &&
              mouseY >= b.yPos && mouseY <= b.yPos + b.buttonHeight) {
          // update this spot when we start creating boss mode
        }
      }
      currmode = selectedMode;
    }
  }
  
  void display() {
    background(0);
    if (modes.size() == 2) {
      for (Button b : modes) {
        b.display();
      }
    }
    else {
      if (selectedMode.equals("Versus")) {
        currmode = selectedMode;
      }
      else {
        for (Button b : numPlayers) {
          b.display();
        }
      }
    }
  }
  
}
