class bulle_heros {
  float x;
  float y;
  float lag; 
  float radius;


  bulle_heros() {
    this.x = mouseX;
    this.y = mouseY;
    lag = 0.1;
    radius = 30;
  }
  void affichage_heros() {
    fill(255, 255, 0);
    noStroke();
    ellipse(this.x, this.y, radius, radius);
  }
  void mouvement_heros() {
    this.x = lerp(this.x, mouseX, lag);
    this.y = lerp(this.y, mouseY, lag);
  }
  void circleTail() {
    fill(255, 255, 255, 20);
    noStroke();
    rect(0, 0, 1920, 1080);
  }
}
