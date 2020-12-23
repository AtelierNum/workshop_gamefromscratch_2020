class Chara { //classe du personnage du joueur

  float posCercleX;
  float posCercleY;

  Chara(float tempPosCercleX, float tempPosCercleY) {

    tempPosCercleX = posCercleX;
    tempPosCercleY = posCercleY;
  }
  void displayChara() { //créé le cercle qui suit la souris

    image(willo, posCercleX, posCercleY, 80, 80);
  }

  void moveChara(float posSourisX, float posSourisY) {

    posCercleX = lerp(posSourisX, posCercleX, 0.9);
    posCercleY = lerp(posSourisY, posCercleY, 0.9);
  }
}
