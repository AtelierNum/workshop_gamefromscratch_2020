// Importation des sons
Ball balle;
import processing.sound.*;
SoundFile theme;
SoundFile levelup;

// ArrayLists de mes objets

ArrayList <GB> mechants = new ArrayList <GB>();
ArrayList <GEL> mechants2 = new ArrayList <GEL>();
ArrayList <P> gentils = new ArrayList <P>();
ArrayList<Level> levels = new ArrayList <Level>();

// Les Variables

int score;
int Vie = 8;
boolean isWin = false;
int timer;
int currentLevelID = 0;
Level currentLevel;

int agentsNumber;

int agentRatePop;

int vilainNumber;

int vilainRatePop;

int gelNumber;

int gelRatePop;

int agentEaten;

int nPoppedAgent = 0;

int nPoppedVilain = 0;

int nPoppedGel = 0;

// Nom de mes sprites

PImage Virus;
PImage Masque;
PImage Gel;
PImage Perso1;
PImage Perso2;
PImage Decor1;
PImage Decor2;
PImage Decor3;
PImage Decor4;

void setup() {


  fullScreen(); 
  textAlign(CENTER);
  frameRate(60);

  // Mise en place des sons

  theme = new SoundFile(this, "theme.wav");
  levelup = new SoundFile(this, "levelup.wav");

  // Mise en place des images

  Decor4 = loadImage("Decor4.png");
  Decor3 = loadImage("Decor3.png");
  Decor2 = loadImage("Decor2.png");
  Decor1 = loadImage("Decor1.png");
  Virus = loadImage("Virus.png");
  Masque = loadImage("Masque.png");
  Gel = loadImage("Gel.png");
  Perso1 = loadImage("Perso1.png");
  Perso2 = loadImage("Perso2.png");

  // Ajouts de différents lv avec des paramètres

  levels.add(new Level(10, 50, 5, 120, 10, 5, 120));
  currentLevelID = 0;
  currentLevel = levels.get(currentLevelID);
  levels.add(new Level(15, 60, 10, 90, 15, 10, 90));
  levels.add(new Level(15, 120, 15, 70, 20, 15, 70));
  levels.add(new Level(20, 180, 20, 50, 25, 20, 50));
  levels.add(new Level(30, 180, 12, 50, 25, 13, 50));

  // Spawn de ma boule principale

  balle = new Ball(width/2, height/2);

  // Ajout de la bande sonore principal qui est loop en fin de musique

  theme.loop(1);

  // Ajout des agents bons et mauvais

  for (int i=0; i<3; i++) {
    mechants.add(new GB(color(255, 0, 0), 0.05, random(500)));
  }

  // Les 2 sprites gentils vont spawn a 50% avec une sprite et 50% avec une autre

  for (int o=0; o<5; o++) {
    if (random(100) < 50) {
    } else {
      gentils.add(new P(Perso2, 0.05, random(500)));

      gentils.add(new P(Perso1, 0.05, random(500)));
    }

    for (int i=0; i<2; i++) {
      mechants2.add(new GEL(color(255, 0, 0), 0.05, random(500)));
    }
  }
}

// Debut de la boucle qui se répète à toutes les frames

void draw() {


  motionBlur(50);

  // Mise en place d'un décor pour chaque niveau 

  if (currentLevelID == 0) {
    tint(255, 90);
    image(Decor1, 0, 0);
    tint(255, 255);
  }

  if (currentLevelID == 1) {
    tint(255, 90);
    image(Decor2, 0, 0);
    tint(255, 255);
  }

  if (currentLevelID == 2) {
    tint(255, 90);
    image(Decor3, 0, 0);
    tint(255, 255);
  }

  if (currentLevelID == 3) {
    tint(255, 90);
    image(Decor4, 0, 0);
    tint(255, 255);
  }

  // Permet de changer de niveau quand le nombre d'agents à manger par niveau est atteint

  if (agentEaten >= currentLevel.agentEaten) {

    gentils.clear();
    mechants.clear();
    mechants2.clear();
    nextLevel();
  }

  // Apparition des différents void

  balle.display();

  displayNiveau();

  displayScore();

  displayVie();

  // Condition de défaite

  if (Vie<=0 && isWin == false) {
    gameOver();
  }

  // Condition de victoire

  if (currentLevelID >= 4 && isWin == false) {
    Win();
  }

  // Système pour perdre une vie lorque l'on touche aux masques 

  for (int i =0; i < mechants.size(); i++ ) {
    GB a = mechants.get(i); 
    a.move(); 
    a.display(); 
    if (dist(balle.xpos, balle.ypos, a.xpos, a.ypos)<80) {
      mechants.remove(i);
      Vie--;
    }
  }

  // Système pour perdre une vie lorque l'on touche aux gels

  for (int i =0; i < mechants2.size(); i++ ) {
    GEL a = mechants2.get(i); 
    a.move(); 
    a.display(); 
    if (dist(balle.xpos, balle.ypos, a.xpos, a.ypos)<80) {
      mechants2.remove(i);
      Vie--;
    }
  }

  // Système pour gagner du score lorsque l'on touche un personnage

  for (int o =0; o < gentils.size(); o++ ) {
    P a = gentils.get(o); 
    a.move(); 
    a.display(); 
    if (dist(balle.xpos, balle.ypos, a.xpos, a.ypos)<80) {
      gentils.remove(o);
      score ++;
      agentEaten ++;
    }
  }

  // Permet de déplacer le virus avec la souris

  balle.update(mouseX, mouseY, 0.015);

  // Je fixe le délai de pop des personnages avec 1 chances sur 2 sur les 2 sprites disponibles

  if (frameCount % currentLevel.agentRatePop == 0 && nPoppedAgent < currentLevel.agentNumber) {
    for (int o = 0; o < 1; o++) {
      if (random(100) < 50) {
      } else {
        gentils.add(new P(Perso2, 0.05, random(500)));

        gentils.add(new P(Perso1, 0.05, random(500)));
      }
      nPoppedAgent += 1;
    }

    // Je fixe le délai de pop des masques 

    if (frameCount % currentLevel.vilainRatePop == 0 && nPoppedVilain < currentLevel.vilainNumber) {
      for (int i = 0; i < 1; i++) {
        mechants.add(new GB(color(255, 0, 0), 0.05, random(500)));
        nPoppedVilain += 1;
      }

      // Je fixe le délai de pop des gels

      if (frameCount % currentLevel.gelRatePop == 0 && nPoppedGel < currentLevel.gelNumber) {
        for (int i = 0; i < 1; i++) {
          mechants2.add(new GEL(color(255, 0, 0), 0.05, random(500)));
          nPoppedGel += 1;
        }
      }
    }
  }
}

// Void de la trainée

void motionBlur(int transparency) {
  noStroke(); 
  fill(0, transparency); 
  rect(0, 0, width, height);
}

// Void du texte du score

void displayScore() {
  fill(255);
  textSize(35);
  text("Score : "+score, 100, 75);
}

// Void du texte de la vie

void displayVie() {
  fill(255);
  textSize(35);
  text("Vie : " +Vie, 1820, 75);
}

// Void du texte niveau

void displayNiveau() {
  fill (255);
  textSize(32);
  text("Niveau : "+currentLevelID, width/2, 75);
}

// Void de l'écran de Game Over

void gameOver() {
  image(Decor1, 0, 0);
  fill(255);
  textSize(40);
  text("Game Over !", width/2, height/2);
  text("Click to restart", width/2, 750);
}

// Void qui permet de relancer le jeu lorsque que l'on clique

void mouseClicked() {
  mechants.clear();
  gentils.clear();
  mechants2.clear();
  score = 0;
  Vie = 5;
  setup();
}

// Void du texte de la victoire

void Win() {
  background(0);
  fill(255);
  textSize(50);
  text("Bravo tu as contaminé la planète !", width/2, height/2);
  text("Click to restart", width/2, 750);
}

// Void qui permet de passer au niveau supérieur

void nextLevel() {

  // Reinitialisation quand l'on passe d'un niveau

  levelup.play();
  currentLevelID+= 1;
  currentLevel = levels.get(currentLevelID);
  agentEaten = 0;
  nPoppedAgent = 0;
  nPoppedVilain = 0;
  nPoppedGel = 0;
  score = 0;

  //  Permet le respawn des gentils/méchants après le changement d'un niveau

  for (int i=0; i<currentLevel.vilainNumber; i++) {
    mechants.add(new GB(color(255, 0, 0), 0.05, random(500)));
  }
  for (int o=0; o<currentLevel.agentNumber; o++) {
    if (random(100) < 50) {
    } else {
      gentils.add(new P(Perso2, 0.05, random(500)));

      gentils.add(new P(Perso1, 0.05, random(500)));
    }
  }

  for (int i=0; i<currentLevel.agentNumber; i++) {
    mechants2.add(new GEL(color(255), 0.05, random(500)));
  }
}
