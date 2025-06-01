public class screenSelect {
  ArrayList<Button> modes = new ArrayList<Button>();
  ArrayList<Button> numPlayers = new ArrayList<Button>();
  
  // ==== Character Select ====  
  ArrayList<Character> charOptions = new ArrayList<Character>();
  int p1Index, p2Index;
  boolean p1Chosen, p2Chosen;
  Character p1Choice, p2Choice;
  
  String selectedMode;
  
  public screenSelect() {
    modes.add(new Button(width/2-400,height/2-150,300,300, "Versus", "versus.png"));
    modes.add(new Button(width/2+100,height/2-150,300,300, "Boss", "boss.png"));
    
    numPlayers.add(new Button(width/2-400,height/2-150,300,300, "1", "onep.png"));
    numPlayers.add(new Button(width/2+100,height/2-150,300,300, "2", "twop.png"));
    
    p1Index = 0; p2Index = 0;
    p1Chosen = false; p2Chosen = false;
    
    charOptions.add(new catFirst(20, 20, 60, 0, 0));
    charOptions.add(new catFirst(20, 20, 60, 0, 0));
    charOptions.add(new catFirst(20, 20, 60, 0, 0));
  }
  
  void buttonClicked() {
    if (modes.size() == 2) {
      for (int x = 0; x < modes.size(); x++) {
        Button b = modes.get(x);
        if (mouseX >= b.xPos && mouseX <= b.xPos + b.buttonWidth &&
              mouseY >= b.yPos && mouseY <= b.yPos + b.buttonHeight) {
          selectedMode = modes.remove(x).value;
          if (selectedMode.equals("Versus")) {
            numPlayer = "2";
            currmode = "CharacterSelect";
          }
        }
      }
    } else if (selectedMode.equals("Boss")) {
      for (int x = 0; x < numPlayers.size(); x++) {
        Button b = numPlayers.get(x);
        if (mouseX >= b.xPos && mouseX <= b.xPos + b.buttonWidth &&
              mouseY >= b.yPos && mouseY <= b.yPos + b.buttonHeight) {
          numPlayer = b.value;
          currmode = "CharacterSelect";
        }
      }
    }
  }
  
  void displayCharSelect() {
    background(0);
    textAlign(CENTER);
    fill(255);
    textSize(32);
    text("Character Select", width / 2, 80);
    textSize(20);
    text("Press ENTER to start", width / 2, height - 60);
  
    for (int i = 0; i < charOptions.size(); i++) {
      float x = width / 2 - 300 + i * 200;
      float y = height / 2;
      image(charOptions.get(i).getPreview(), x, y, 100, 100);
  
      if (i == p1Index) text("P1", x + 50, y + 120);
      if (numPlayer.equals("2") && i == p2Index) text("P2", x + 50, y + 150);
    }
  }
  
  void display() {
    background(0);
    if (currmode.equals("CharacterSelect")) {
      displayCharSelect();
    } 
    else if (modes.size() == 2) {
      for (Button b : modes) {
        b.display();
      }
    }
    else {
      if (selectedMode.equals("Versus")) {
        selectScreen = false;
        currmode = selectedMode;
        numPlayer = "2";
      }
      else {
        for (Button b : numPlayers) {
          b.display();
        }
      }
    }
  }
  
}
