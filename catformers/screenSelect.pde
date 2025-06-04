public class screenSelect {
  ArrayList<Button> modes = new ArrayList<Button>();
  ArrayList<Button> numPlayers = new ArrayList<Button>();
  Button demoToggle;
  
  // ==== Character Select ====  
  ArrayList<Character> charOptions = new ArrayList<Character>();
  int p1Index, p2Index;
  
  String selectedMode;
  
  public screenSelect() {
    modes.add(new Button(width/2-400,height/2-150,300,300, "Versus", "versus.png"));
    modes.add(new Button(width/2+100,height/2-150,300,300, "Boss", "boss.png"));
    
    numPlayers.add(new Button(width/2-400,height/2-150,300,300, "1", "onep.png"));
    numPlayers.add(new Button(width/2+100,height/2-150,300,300, "2", "twop.png"));
    demoToggle = new Button(width - 100, 20, 60, 30, "Demo Mode");
    
    p1Index = 0; p2Index = 0;
    p1Chosen = false; p2Chosen = false;
    
    charOptions.add(new catFirst(20, 20, 60, 0, 0));
    charOptions.add(new catSecond(20, 20, 60, 0, 0));
    charOptions.add(new catThird(20, 20, 60, 0, 0));
  }
  
  void buttonClicked() {
    if (demoToggle != null && 
    mouseX >= demoToggle.xPos && mouseX <= demoToggle.xPos + demoToggle.buttonWidth &&
    mouseY >= demoToggle.yPos && mouseY <= demoToggle.yPos + demoToggle.buttonHeight) {
      demoToggle.toggle();
      demoMode = demoToggle.toggleState;
    }
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
    pushStyle();
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
      float previewH;
      if (i!=0) previewH = (previewW - 10) * charOptions.get(i).hitboxLength/charOptions.get(i).hitboxWidth;
      else previewH = (previewW + 10) * 70/55;
      float x = width / 2 - 320 + i * 250;
      float y; 
      if (i==1) y = height / 2 - 115;
      else y = height / 2 - 100;
      textSize(22);
      text(names[i], x + previewW/2, height / 2 - 120);
      image(charOptions.get(i).getPreview(), x, y, previewW, previewH);
      textSize(18);
      if (i == p1Index) {
        if (p1Chosen) fill(255,0,0);
        text("P1", x + previewW/2, (height / 2 - 100) + ((previewW + 10) * 70/55) + 60);
        fill(200);
      }
      if (numPlayer.equals("2") && i == p2Index) {
        if (p2Chosen) fill(255,0,0);
        text("P2", x + previewW/2, (height / 2 - 100) + ((previewW + 10) * 70/55) + 80);
        fill(200);
      }
      text(desc[i], x + previewW/2, (height / 2 - 100) + ((previewW + 10) * 70/55) + 110);
    }
    popStyle();
  }
  
  Character generateChar(int index) {
    if (index == 0) {
      return new catFirst(20, 20, 60, 0, height - 125);  // Chill Cat
    } else if (index == 1) {
      return new catSecond(15, 15, 60, 0, height - 125); // Alien Cat
    } else if (index == 2) {
      return new catThird(15, 15, 60, 0, height - 125);  // Bomber Cat
    }
    return new catFirst(15, 15, 60, 0, height - 125);
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
    } else {
      if (selectedMode.equals("Versus")) {
        selectScreen = false;
        currmode = selectedMode;
        numPlayer = "2";
      }
      else {
        for (Button b : numPlayers) {
          b.display();
        }
        demoToggle.display();
      }
    }
  }
  
}
