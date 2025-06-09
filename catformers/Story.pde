public class Story {
  // ==== Typewriter Effect ====
  String[] dialogue;
  String displayedText, currentSpeaker;
  int dialogueIndex, charIndex;
  boolean lineOver;

  // ==== Dialogue ====
  String[] introDialogue = {
    "I'm so hungry!! The big bad dog stole our _ :(",
    "Wait...can dogs even eat _??",
    "Um...I smell dog in that direction!",
    "Let's go look for them!!"
  };
  
  String[] scene2Dialogue = {
    "Look it's the Dog Gang!",
    "We'll beat them and get our food back!!"
  };
  
  String[] postFightDialogue = {
    ".."
  };
  
  String[] winDialogue = {
    "We did it!"
  };
  
  String[] loseDialogue = {
    ".."
  };

  boolean storyOver;
  
  int storyPhaseNum = 0;
  boolean phaseTriggered = false;

  Story() {
    setDialogue(introDialogue);
  }
  
  void setDialogue(String[] nextDialogue) {
    dialogue = nextDialogue;
    displayedText = "";
    dialogueIndex = 0;
    charIndex = 0;
    lineOver = false;
    storyOver = false;
    currentSpeaker = "P1";
  }

  //typewriter effect
  void typeDialogue() {
    if (!lineOver && dialogueIndex < dialogue.length) {
      if (frameCount % 2 == 0 && charIndex < dialogue[dialogueIndex].length()) {
        displayedText += dialogue[dialogueIndex].charAt(charIndex);
        charIndex++;
      }
      if (charIndex >= dialogue[dialogueIndex].length()) {
        lineOver = true;
      }
    }
  }

  void advanceDialogue() {
    if (lineOver) {
      dialogueIndex++;
      if (dialogueIndex < dialogue.length) {
        displayedText = "";
        charIndex = 0;
        lineOver = false;
        if (dialogueIndex % 2 == 0) {
          currentSpeaker = "P1";
        } else {
          currentSpeaker = "P2";
        }
      } else {
        storyOver = true;
      }
    }
  }
  
  void updateStoryPhase() {
    storyPhase = true;
              
    if (!phaseTriggered) {
      storyPhaseNum++;
      setupNextPhase();
      phaseTriggered = true;
      
      p1Char.startX = 0;
      p1Char.xPos = p1Char.startX;
      if (numPlayer.equals("2")) {
        p2Char.startX = 0;
        p2Char.xPos = p2Char.startX;
        p2Char.facingRight = true;
        p2Char.aimAngle = p1Char.aimAngle;
      }
    }
  }
  
  void setupNextPhase() {
    if (storyPhaseNum == 1) {   
      platforms.add(new Platforms(0, height - 20, 50));
    
      platforms.add(new Platforms(100, 550, 100));
      platforms.add(new Platforms(250, 500, 100));
      platforms.add(new Platforms(400, 440, 100));
      
      platforms.add(new Platforms(600, 390, 80));
      platforms.add(new Platforms(720, 350, 80));
    
      platforms.add(new Platforms(850, 300, 100));
      platforms.add(new Platforms(1000, 250, 150));
      
      platforms.add(new Platforms(1200, 200, 100));

    } else if (storyPhaseNum == 2) {
      story.setDialogue(scene2Dialogue);
      platforms.clear();
      platforms.add(new Platforms(0, height-20, width));
      
      enemies.add(new Enemies(width - 320, height-90, 70, 70/1.38));
      enemies.add(new Enemies(width - 220, height-120, 100, 100/1.38));
      enemies.add(new Enemies(width - 80, height-170, 70, 70/1.38));
    } else if (storyPhaseNum == 3) {
    }
    phaseTriggered = false;
  }

  void display() {
    background(bg1);
    if (!transition && !gamePause) typeDialogue();
    
    pushStyle();
    int boxH = 200, boxW = 900;
    int boxX = (width - boxW)/2, boxY = height - boxH - 100;
    fill(0, 100);
    stroke(255, 100);
    strokeWeight(2);
    rect(boxX, boxY, boxW, boxH, 20);
    int size = 500;
    int textX = boxX + 30, textW = boxW - 60;
    if (currentSpeaker.equals("P1")) {
      image(p1Char.getPreview(), 20, height - size, size, size); 
      textX = boxX + 300;
    } else if (currentSpeaker.equals("P2") && p2Char != null) {
      image(p2Char.getPreview(), width - size - 40, height - size, size, size); 
      textX = boxX + 80;
    } 
    fill(255);
    textAlign(LEFT);
    textSize(24);
    text(story.displayedText, textX, boxY + 50, textW, boxH - 60);
    if (lineOver && !storyOver) {
      textSize(16);
      fill(220);
      textAlign(CENTER);
      text("Press [ENTER] or click to continue", width/2, boxY + boxH - 20);
    }
    popStyle();
  }
  
}
