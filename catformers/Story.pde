public class Story {
  // ==== Typewriter Effect ====
  String[] dialogue;
  String displayedText, currentSpeaker;
  int dialogueIndex, charIndex;
  boolean lineOver;

  // ==== Dialogue ====
  String[] introDialogue = {
    "P1: I'm so hungry!! The big bad dog stole our _ :(",
    "P2: Wait...can dogs even eat _??",
    "P1: Um...Look, it's the Dog Gang!",
    "P2: We'll beat them and get our food back!!"
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
        
        String line = dialogue[dialogueIndex];
        if (line.startsWith("P1:") || line.startsWith("P2:")) {
          currentSpeaker = line.substring(0, 2);
          line = line.substring(3);
        } else {
          currentSpeaker = "P1";
        }
        dialogue[dialogueIndex] = line;
        displayedText = "";
        charIndex = 0;
        lineOver = false;
      } else {
        storyOver = true;
      }
    }
  }
  
  void display() {
    background(bg1);
    typeDialogue();
    fill(0, 200);
    noStroke();
    rect(0, height/2 - 80, width, height/2);
    if (currentSpeaker.equals("P1")) {
      image(p1Char.getPreview(), 40, height/2 - 40, 500, 500);
    } else if (currentSpeaker.equals("P2") && p2Char != null) {
      image(p2Char.getPreview(), width-340, height/2 -40, 500, 500);
    }
    fill(255);
    textAlign(CENTER);
    textSize(28);
    text(story.displayedText, width/2, height/2 + 60);
    if (story.lineOver && !story.storyOver) {
      textSize(16);
      fill(220);
      text("Press any key to continue", width/2, height/2 - 40);
    }
  }
  
}
