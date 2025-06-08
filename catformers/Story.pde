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
    "Um...Look, it's the Dog Gang!",
    "We'll beat them and get our food back!!"
  };
  
  String[] scene2Dialogue = {
    "..."
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

  void display() {
    background(bg1);
    typeDialogue();
    
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
