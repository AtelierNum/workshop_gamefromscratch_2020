float ellipseSize =100;
float sensitivity = 0.05;
float tempPosCercleX;
float tempPosCercleY;

class Eater {

  float posCercleX;
  float posCercleY;

  Eater(float posCercleX, float posCercleY) {


    posCercleX = tempPosCercleX;
    posCercleY = tempPosCercleY;
  }
  void display() { 

    image(homer, posCercleX-50, posCercleY-50, ellipseSize, ellipseSize);
    fill(100, 255, 255, 50);
    stroke(255, 255, 255);
    //ellipse(posCercleX, posCercleY, ellipseSize, ellipseSize);
    /*image(gif[currentPic], posCercleX, posCercleY, ellipseSize, ellipseSize);
    currentPic++;
    if (currentPic > 23) {
      currentPic = 0;
    }*/
  }

  float attract(float target, float position, float sensitivity) {
    position = (target - position) * sensitivity + position;
    return position;
  }
  void move(float posSourisX, float posSourisY, float sensitivity) {
    posCercleX = attract(posSourisX, posCercleX, sensitivity);
    posCercleY = attract(posSourisY, posCercleY, sensitivity);
  }
  void circleTail() { 

    fill(0, 100);
    noStroke();
    rect(0, 0, width, height);
  }
}
