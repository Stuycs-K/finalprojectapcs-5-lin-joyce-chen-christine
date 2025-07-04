public class Story {
  // ==== Typewriter Effect ====
  String[] dialogue;
  String displayedText, currentSpeaker;
  int dialogueIndex, charIndex;
  boolean lineOver;

  // ==== Dialogue ====
  String[] introDialogue = {
    "I'm so hungry!! The big bad dog stole our catnip :(",
    "Wait...can dogs even eat catnip??",
    "Um...I smell dog in that direction!",
    "Let's go look for them!!"
  };
  
  String[] introDialogue1P = {
    "I know you're scared of heights, don't worry, \nI'll carry you!!",
    "Really...thank you so much!!"
  };
  
  String[] scene2Dialogue = {
    "That was so exciting!",
    "We made it!——And look, it's the Dog Gang!",
    "The food stealers!!",
    "We'll beat them and get our food back."
  };
  
  String[] scene2Dialogue1P = {
    "No, wait——I'm training to be buff! \nYou can hide, I'll fight for us!!",
    "All right, stay safe, I believe in you!"
  };
  
  String[] postFightDialogue = {
    "Dogs are strong...",
    "Wait, look! What is that??"
  };
  
  String[] postFightDialogue1P = {
    "If I fight the big dog by myself, \nI'll be the world's strongest cat!",
    "You already are. But, okay, I'll watch you then!"
  };
  
  String[] loseDialogue = {
    "The dog is eating our food!",
    "Oh no...I don't think it can eat catnip.",
    "He looks like a sad dog...",
    "Wait a minue———he's crying! What do we do??",
    "...I'm a sad cat now.",
    "Let's just go back to the start..."
  };

  boolean storyOver, finalDialogue = false;
  
  int storyPhaseNum = 0;
  boolean phaseTriggered = false;

  Story() {
    if (numPlayer.equals("1")) {
      setDialogue(concat(introDialogue, introDialogue1P));
    } else {
      setDialogue(introDialogue);
    }
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
        if (storyPhaseNum == 4) {
          currmode = "Loss";
          modeInitialized = false;
        }
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
      
      storyTriggered = false;
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
      if (numPlayer.equals("1")) {
        setDialogue(concat(scene2Dialogue, scene2Dialogue1P));
      } else {
        setDialogue(scene2Dialogue);
      }
      platforms.clear();
      platforms.add(new Platforms(0, height-20, width));
      
      enemies.add(new Enemies(width - 320, height-90, 70, 70/1.38));
      enemies.add(new Enemies(width - 220, height-120, 100, 100/1.38));
      enemies.add(new Enemies(width - 80, height-170, 70, 70/1.38));
    } else if (storyPhaseNum == 3) {
      if (numPlayer.equals("1")) {
        setDialogue(concat(postFightDialogue, postFightDialogue1P));
      } else {
        setDialogue(introDialogue);
      }
    } else if (storyPhaseNum == 4) { //<GLORP>
      if (!finalDialogue) {
        if (gameEnd && prevMode.equals("Loss")) {
          setDialogue(loseDialogue);
        }
        finalDialogue = true;
      }
      storyOver = false;
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
    } else if (currentSpeaker.equals("P2")) {
      if (numPlayer.equals("2") && p2Char != null) {
        image(p2Char.getPreview(), width - size - 40, height - size, size, size);
      } else {
        image(cat1idleL, width - size - 30, height - size, size, size);
      }
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
