bulle_heros bh;
int health = 40;

float collision = 30;

ArrayList<bulle> bulles;
ArrayList<Level> levels;

int currentLevelID;
Level currentLevel;

import processing.sound.*;
SoundFile song;
//SoundFile erreur;

boolean ecranWin = false;

Float time;

void setup() {//lancement des premières informations du programme
  //fullScreen();
  size(800, 800);
  background(0);

  bulles = new ArrayList<bulle>();//création d'un espace mémoire pour les bulles multiples 
  bh = new bulle_heros();//création d'un espace mémoire pour la bulle jaune 


  for (int i=0; i<100; i++) {//nombre de balles 
    bulles.add(new bulle());
  }

  levels = new ArrayList<Level>();
  levels.add(new Level(1, 2));//niveau 0 : lag de la souris, vitesse de respawn des bulles
  levels.add(new Level(0.02, 10));//niveau 1 : 
  levels.add(new Level(0.03, 5));//niveau 2 : 
  currentLevelID = 0;
  currentLevel = levels.get(currentLevelID);

  song = new SoundFile(this, "song.wav");
  //song = new SoundFile(this, "erreur.wav");
  
  song.loop();
}
void draw() {//boucle qui recycle le programme ci-dessous

  println(health, currentLevelID, ecranWin);
  background(0);
  bh.mouvement_heros();
  bh.affichage_heros();
  vie();
  text("time : " +millis()/1000, width/15*12, 115);



  for (int i=0; i < bulles.size(); i++) {
    bulle a = bulles.get(i);
    a.mouvement();
    a.affichage();
    if (dist(bh.x, bh.y, a.x, a.y)<collision) {
      bulles.remove(i);
      for (int j=0; j<currentLevel.nbBulleAdd; j++) {
        bulles.add(new bulle());
      }
      health--;
      bh.radius +=5;//augmentation de la taille de la bulle jaune à chaque fois qu'elle touche les autres
    }
  }

  if (second()%10 == 0 && ecranWin == false) {//augmentation consécutive du niveau après chaque 10000 millisecondes
    currentLevelID ++;
    if (currentLevelID < levels.size()) {//tant que le joueur n'a pas dépassé le nombre maximum de niveau, il ne sort pas de la boucle
      currentLevel = levels.get(currentLevelID);
      bh.lag = currentLevel.heroLag;
    } else {
      ecranWin = true;
    }
    bh.lag = currentLevel.heroLag;
  }
  if (health<0) {
    background(200, 0, 0);
    fill(255);
    text("You have no more health...Try again", width/2, height/2);//le game over du jeu
    textSize(300);
    textAlign(CENTER);
  } else {
    if (health<30) {//ligne de code qui ne fonctionne pas, health doit changer de couleur lorsque health descend sous 30
      fill(#FFF303);
      textSize(100);
    }
  }
  if (ecranWin == true) {
    ecranWin();
  }
  if (collision<bh.radius) {
    collision = bh.radius/2;
  }
}
void vie() {
  fill(255);
  textSize(50);
  text("Health : "+health, width/15, 115);
}

void ecranWin() {
  background(0, 200, 0);
  fill(255);
  text("You win ! But you can try again", width/2, height/2);//signal de fin de jeu, où le joueur ressort gagnant
  textSize(300);
  textAlign(CENTER);
}
