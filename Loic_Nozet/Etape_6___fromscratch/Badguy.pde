class Badguy {

  float xpos;
  float ypos;
  float xoff = random(0, 1);
  float yoff = random(0, 900);
  float seed;
  float incr;
  float speed;
  

  Badguy(float _seed) {
    this.xpos = random(width);
    this.ypos = random(height);
    this.seed = _seed;
    this.incr=0;
    this.speed = 0.05;
  }

  void display() {

    image(burns,this.xpos, this.ypos, 80, 80);
    stroke(255);
    fill(255, 0, 0);
   // ellipse(this.xpos, this.ypos, 30, 30);
  }
  void move() {

    incr = incr + this.speed;
    xpos = xpos + (noise(incr, 50+this.seed)-0.5)*difficultySpeedBG;
    ypos = ypos + (noise(incr, 20+this.seed)-0.5)*difficultySpeedBG;

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
