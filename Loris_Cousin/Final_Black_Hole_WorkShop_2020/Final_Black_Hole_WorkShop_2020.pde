int ellipse1 = 60;
int x1 = mouseX;
int y1 = mouseY;
float x;
float y;
float nbmechant = 2;
float nbgentil = 2; 
int score = 0;
boolean isGameOver = false;
boolean isWinner = false;
PImage espaceBackground;
PImage planeteBleu;
PImage planeteRouge;

Level currentLevel;

int currentLevelID = 0;

ArrayList<Agent> mechants = new ArrayList<Agent>();
ArrayList<Agent> gentils = new ArrayList<Agent>();
ArrayList<Level> levels = new ArrayList<Level>();

//Balle b1;
//Balle b2;

int agentEaten = 0;


void setup() {
  espaceBackground = loadImage("espace.png");
  planeteBleu = loadImage("planetebleu.png");
  planeteBleu = loadImage("planeterouge.png");

  fullScreen();
  espaceBackground.resize(width, height);
  //  b1 = new Balle (50);
  //  b2 = new Balle (50);

  for (int i=0; i<nbmechant; i++) {
    mechants.add(new Agent(i, color(200, 100, 0)));
  }
  for (int i=0; i<nbgentil; i++) {
    gentils.add(new Agent(i, color(0, 100, 255)));
  }
  levels.add(new Level(2, 1000000000, 1000000000 ));
  levels.add(new Level(10, 180, 180));
  levels.add(new Level(15, 140, 140));
  levels.add(new Level(20, 120, 120));
  levels.add(new Level(25, 100, 100));
  levels.add(new Level(30, 80, 80));
  levels.add(new Level(50, 60, 60));

  currentLevel = levels.get(currentLevelID);
  println(levels.size());
}

void draw() {


  if (isGameOver == false && isWinner == false) {
    image(espaceBackground, 0, 0);
    fill(0, 0, 0, 10);
    rect(0, 0, 1300, 900);
    fill(255);
    noStroke();
    x = lerp(x, x1, 0.05);
    y = lerp(y, y1, 0.05);
    fill(0, 100, 255);
    ellipse(x, y, ellipse1, ellipse1);
    fill(200, 100, 0);
    ellipse(width-x, height-y, 60, 60);
    fill(0);
    ellipse(width-x, height-y, 50, 50);
    fill(0);
    ellipse(x, y, 50, 50);
    x1 = mouseX;
    y1 = mouseY;
    //  b1.display();
    //  b2.display();

    for (int i = 0; i < mechants.size(); i++) {
      Agent a = mechants.get(i);
      a.move();
      a.display();
      //a.speed = mouseX/width;
      if (dist(x, y, a.xpos, a.ypos)<40) {
        isGameOver = true;
      }
      if (dist(width-x, height-y, a.xpos, a.ypos)<40) {
        //isGameOver = true;
        mechants.remove(i);
        agentEaten ++;
        score ++;
      }
    }

    for (int i = 0; i < gentils.size(); i++) {
      Agent a = gentils.get(i);
      a.move();
      a.display();
      //a.speed = mouseX/width;
      if (dist(x, y, a.xpos, a.ypos)<40) {
        gentils.remove(i);
        score ++;
        agentEaten ++;
      }
      if (dist(width-x, height-y, a.xpos, a.ypos)<40) {
        //gentils.remove(i);
        //score ++;
        isGameOver = true;
      }
    }
    respawn();
    score();
    if (agentEaten >= currentLevel.agentToEat) {
      nextLevel();
    }
    displayLevelID();
  } else if (isGameOver == true) {
    gameOver();
  } else if (isWinner ==true) {
    win();
  }
}

void respawn() {
  int i = 80;
  if (frameCount % currentLevel.RatePopMechants == 0) {
    nbmechant ++;
    i++;
    mechants.add(new Agent(i, color(200, 100, 0)));
  }
  if (frameCount % currentLevel.RatePopGentils == 0) {
    nbgentil ++;
    i++;
    gentils.add(new Agent(i, color(0, 100, 255)));
  }
}

void score() {
  fill(255);
  textSize (40);
  text("Score : "+score, width/2.5, 50);
}

void displayLevelID() {
  fill(255);
  textSize (40);
  text("Level : "+currentLevelID, width/2.5, 90);
}

void gameOver() {
  background(250, 0, 40);
  fill(0);
  textSize(50);
  textAlign(CENTER);
  text("Game Over !", width/2, height/2);
  fill(0);
  textSize(50);
  textAlign(CENTER);
  text("Press A to restart", width/2, height/2 + 130);
  mechants.clear();
  gentils.clear();
}

void win() {
  background(0, 255, 100);
  fill(0);
  textSize(50);
  text("      You Win !", width/3, height/2);
}


void nextLevel() {
  println("current Level " + currentLevelID);
  currentLevelID +=1;
  if (currentLevelID <= levels.size()-1) {
    currentLevel = levels.get(currentLevelID);
  } else {
    isWinner = true;
  }
}

void keyTyped() {
  if (key == 'a') {
    if (isGameOver == true) {
      restart();
    } else if (isWinner == true) {
      restart();
    }
  }
}


void restart() {
  nbmechant = 2;
  nbgentil = 2; 
  score = 0;
  agentEaten =0;
  currentLevelID = 0;
  currentLevel = levels.get(currentLevelID);
  isGameOver = false;
  isWinner = false;
  mechants.clear();
  gentils.clear();
  for (int i=0; i<nbmechant; i++) {
    mechants.add(new Agent(i, color(200, 100, 0)));
  }
  for (int i=0; i<nbgentil; i++) {
    gentils.add(new Agent(i, color(0, 100, 255)));
  }
}
