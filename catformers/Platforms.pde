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
    if (s.selectedMap != null && s.selectedMap.equals("Map3")) {
      image(cloudPlatform, xPos, yPos, platformWidth, platformHeight);
    } else {
    image(loadImage("dirtplatform.png"), xPos, yPos, platformWidth, platformHeight);
    }
  }


}
