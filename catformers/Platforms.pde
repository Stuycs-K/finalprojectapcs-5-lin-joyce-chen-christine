public class Platforms {
  int xPos, yPos;
  int platformWidth, platformHeight;

  public Platforms (int xPos, int yPos, int platformWidth) {
    this.xPos = xPos;
    this.yPos = yPos;
    this.platformWidth = platformWidth;
    platformHeight = 20;

  }

  void display() {
    image(loadImage("dirtplatform.png"), xPos, yPos, platformWidth, platformHeight);
  }


}
