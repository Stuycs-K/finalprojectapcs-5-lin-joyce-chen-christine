public class Story {
  // ==== Typewriter Effect ====
  String[] dialogue;
  String displayedText;
  int dialogueIndex, charIndex;
  boolean lineOver;
  
  boolean storyOver;
  
  Story(String[] dialogue) {
    this.dialogue = dialogue;
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
    
