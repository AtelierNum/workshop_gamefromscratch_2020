class Meteor {
  float xpos;
  float ypos;
  float incr;
  float speed;
  float seed;

  Meteor(float _seed) {
    this.xpos = random (width);
    this.ypos = random (height);
    this.incr = 0;
    this.speed = 0.05;
    this.seed = _seed;
  }

  void display() {
    fill(255, 0, 0);
    strokeWeight(5);
    image(red, this.xpos, this.ypos, 60, 60);
  }

  void moveMeteor (float amp) {
    incr = incr + this.speed;
    xpos = xpos + (noise(incr, 30+this.seed)-0.5)*amp;
    ypos = ypos + (noise(incr, 50+this.seed)-0.5)*amp;

    if (xpos > width) {
      xpos = 0;
    } else {
      if (xpos < 0) {
        xpos = width;
      }
    }
    if (ypos > height) {
      ypos = 0;
    } else {
      if (ypos < 0) {
        ypos = height;
      }
    }
  }
}
