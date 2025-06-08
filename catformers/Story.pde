public class Story {
  // ==== Typewriter Effect ====
  String[] dialogue;
  String displayedText;
  int dialogueIndex, charIndex;
  boolean lineOver;

  // ==== Dialogue ====
  String[] introDialogue = {
    "I'm so hungry!! The big bad dog stole our _ :(",
    "Wait...can dogs even eat _??",
    "Um...Look, it's the Dog Gang!",
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
      } else {
        storyOver = true;
      }
    }
  }
  
}
