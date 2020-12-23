class Agent {
  float xpos;
  float ypos;
  float incr;
  float speed;
  color couleur;

  Agent(float speed, color couleur) {
    this.xpos = random(width);
    this.ypos = random(height);
    this.incr = 0;
    this.speed = speed;
    this.couleur = couleur;
  }
  void display() {
    fill(this.couleur);
    ellipse(this.xpos, this.ypos, 60, 60);
  }
  void move() {
    incr = incr + this.speed;
    xpos = xpos + (noise(13, incr)-0.5)*2;
    ypos = ypos + (noise(35, incr)-0.5)*2;
    if (xpos>width) {
      xpos = 0;
    }
    if (ypos>height) {
      ypos = 0;
    }
    if (xpos<0) {
      xpos = width;
    }
    if (ypos<0) {
      ypos = height;
    }
  }
}
