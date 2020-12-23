class Agent {         //déclaration de classe
 
  float xpos;          //declarations des variables
  float ypos;
  float xoff = random(0, 1);
  float yoff = random(0, 900);
  float seed;
  float incr;
  float speed;

  Agent(float _seed) {
    
    this.xpos = random(width);           //attribution des variables
    this.ypos = random(height);
    this.seed = _seed;
    this.incr=0;
    this.speed = 0.05;
    
  }

  void display() {                    // fonction visuel
    
    image(burger,this.xpos, this.ypos, 50, 50);
    stroke(255);
    fill(255,128,0);
    //ellipse(this.xpos, this.ypos, 20, 20);
  }
  void move() {                  //fonction déplacement

   incr = incr + this.speed;
    xpos = xpos + (noise(incr, 50+this.seed)-0.5)*difficultySpeedA;
    ypos = ypos + (noise(incr, 20+this.seed)-0.5)*difficultySpeedA;

    if (xpos > width) {      //téléportation aux bords opposés de l'écran
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
