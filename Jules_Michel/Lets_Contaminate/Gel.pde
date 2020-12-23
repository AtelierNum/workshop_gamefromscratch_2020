// Création de la classe du gel

class GEL {

 // Les variables 
  
  color c;
  float rad;
  float xpos;
  float ypos;
  float speed;
  float incr;
  float seed;
  
  // Création du constructeur de la classe

  GEL(color tempC, float speed, float seed) {
    c = tempC;
    this.xpos = random(width);
    this.ypos = random(height);
    this.incr = 0;
    this.speed = speed;
    this.seed = seed;
  }
  
    // Void qui permet de montrer les gels avec un sprite

  void display() {
    fill(c);
    image(Gel,this.xpos, this.ypos, 40, 50 );
  }

// Void qui crée des mouvements aléatoires des gels

  void move() {
    incr = incr + this.speed;
    xpos = xpos + (((noise(incr, seed +48)*2)-1)*10);
    ypos = ypos + (((noise(incr, seed + 10)*2)-1)*10);

    if (xpos>width) {
      xpos = 0;
    } else {
      if (xpos < 0)
      {
        xpos = width;
      }
    }
    if (ypos>height) {
      ypos = 0;
    } else {
      if (ypos < 0)
      {
        ypos = height;
      }
    }
  }
}
