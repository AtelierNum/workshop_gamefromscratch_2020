class Player {

  float x, y;
  int x1 = mouseX;
  int y1 = mouseY;
  boolean finished = false;

  void movePlayer() {
    if (finished)
      return;
    x1 = mouseX;
    y1 = mouseY;
    x = lerp(x, x1, 0.05);
    y = lerp(y, y1, 0.05);
  }

  void displayPlayer() {

    fill(0, 195, 225);
    image(blue, x, y, 60, 60);
    stroke(255);
    strokeWeight(5);
  }

  void motionBlur (int transparency) {
    noStroke();
    fill(0, transparency);
    rect (0, 0, width, height);
  }

  void stop() {
    finished = true;
  }
}
