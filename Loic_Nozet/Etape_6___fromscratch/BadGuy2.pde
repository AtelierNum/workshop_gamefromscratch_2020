class Badguy2 {
  
  float xpos;
  float ypos;
  float xoff = random(0, 1);
  float yoff = random(0, 900);
  float seed;
  float incr;
  float speed;

  Badguy2(float _seed) {
    this.xpos = random(width);
    this.ypos = random(height);
    this.seed = _seed;
    this.incr=0;
    this.speed = 0.03;
  }

  void display() {

    image(bob, this.xpos, this.ypos, 250, 200);
    stroke(255);
    fill(255,0,0);
   // ellipse(this.xpos, this.ypos, 60, 60);
  }
  void move() {

    incr = incr + this.speed;
    xpos = xpos + (noise(incr, 50+this.seed)-0.5)*difficultySpeedBG2;
    ypos = ypos + (noise(incr, 20+this.seed)-0.5)*difficultySpeedBG2;

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
