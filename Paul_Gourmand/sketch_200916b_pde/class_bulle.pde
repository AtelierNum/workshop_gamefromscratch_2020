class bulle {//les caractéristiques de la bulle
  float x;
  float y;
  float seed;
  float speedFactor =6;//vitesse des balles qui tombent
  bulle() {
    this.x = random(width);
    this.y = 0;
    this.seed = random(20);
  }
  void affichage() {//son affichage dans le programme
    fill(150, 150, 150);
    stroke(255);
    ellipse(x, y, 20, 20);
  }
  void mouvement() {//son mouvement dans le programme
    x = x + 0;
    y = y + (noise(1, seed)+0.5)*speedFactor;

    if (y>height) {
      y = 0;
      x = random(width);
    }
  }
}
