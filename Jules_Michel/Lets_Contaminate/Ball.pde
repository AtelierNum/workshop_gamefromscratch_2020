// Création de la classe de ma boule principale

class Ball {

  // Liste de mes variables

  float xpos;
  float ypos;

// Création du constructeur de la classe

  Ball(float xpos, float ypos) {
    this.xpos = xpos;
    this.ypos = ypos;
  }

  float attract(float target, float position, float sensitivity) {
    position = (target - position) * sensitivity + position;
    return position;
  }
  
  // Void qui crée un retard entre le mouvement de la souris et le pointeur qui suit la souris (plus la boule se rapproche de la souris plus il ralentit)

  void update(float xtarget, float ytarget, float sensitivity) {
    xpos = attract(xtarget, xpos, sensitivity);
    ypos = attract(ytarget, ypos, sensitivity);
  }
  
  // Void qui permet de montrer la boule et de la remplacer par un sprite

  void display() {
    fill(0, 255, 0);
    image(Virus, xpos, ypos, 90, 80);
  }
}
