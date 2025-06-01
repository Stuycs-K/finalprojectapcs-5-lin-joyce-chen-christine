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
    text("< Select a Catformer >", width / 2, 80);
    textSize(20);
    fill(200);
    if (numPlayer.equals("2")) {
      text("P1: Use A/D to switch and W to select", width/2 - 250, 150);
      text("P2: Use <-/-> to switch and ^ (UP) to select", width/2 + 250, 150);
    } else {
      text("Use A/D to change characters and W to select", width/2, 110);
    }
    text("Press ENTER to Begin Game", width / 2, height - 60);
    
    String[] names = {"Chill Cat", "Alien Cat", "Bomber Cat"};
    String[] desc = {
      "Faster movement speed, higher jump", 
      "Homing bullets",
      "Grenades"
    };
  
    for (int i = 0; i < charOptions.size(); i++) {
      float previewW = 150; 
      float previewH = previewW * 70.0/55.0;
      float x = width / 2 - 320 + i * 250;
      float y = height / 2 - 100;
      textSize(22);
      text(names[i], x + previewW/2, y - 20);
      image(charOptions.get(i).getPreview(), x, y, previewW, previewH);
      textSize(18);
      if (i == p1Index) text("P1", x + previewW/2, y + previewH + 40);
      if (numPlayer.equals("2") && i == p2Index) text("P2", x + previewW/2, y + previewH + 60);
      text(desc[i], x + previewW/2, y + previewH + 90);
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
