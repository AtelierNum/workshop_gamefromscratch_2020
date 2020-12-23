// Création de la classe des personnes à infecter

class P {

// Les Variables
  
  color c;
  float rad;
  float xpos;
  float ypos;
  float speed;
  float incr;
  float seed;
  PImage Perso1;

// Création du constructeur de la classe

  P(PImage p, float speed, float seed) {
    Perso1 = p;
    this.xpos = random(width);
    this.ypos = random(height);
    this.incr = 0;
    this.speed = speed;
    this.seed = seed;
  }
  
   // Void qui permet de montrer les personnages avec un sprite

  void display() {
    image(Perso1,this.xpos, this.ypos,60,80);
    
  }

// Void qui crée des mouvements aléatoires des personnages

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
