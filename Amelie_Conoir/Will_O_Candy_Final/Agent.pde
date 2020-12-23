class Agent { //classe des sprites à attraper et à éviter
  
 
  float xpos;
  float ypos;
  float incr;
  float speed;
  float sizeX;
  float sizeY;
  PImage sprite;


  Agent(PImage sprite, float xpos, float ypos, float sizeX, float sizeY, float speed) {
    
    this.xpos = random(width);
    this.ypos = random(height);
    this.sizeX = sizeX;
    this.sizeY = sizeY;
    this.speed = random(-1,1);
    this.incr = 0;
    this.sprite = sprite;
  }

  void display() {

    image(this.sprite, this.xpos, this.ypos, this.sizeX, this.sizeY);
  }
  void move() {

    incr = incr + 0.05;

    xpos = xpos + (noise(incr, ypos)-0.5)*5; //noise avec valeur incrémentée
    ypos = ypos + (noise(incr, xpos)-0.5)*5;

    if (xpos > width) { // maintains the particles inside of the window
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
